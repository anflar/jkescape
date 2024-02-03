local M = {}

-- Default configuration
local config = {
  time_window = 100, -- Time window in milliseconds for key press detection
  map_insert = {
    jk = '<ESC>',
    kj = '<ESC>',
  },
  map_term = {
    jk = '<C-\\><C-n>',
    kj = '<Up><CR>',
  },
}

-- Function to handle key press with time window consideration
function M.handle_key_press(key)
  local current_time = vim.loop.now() -- Current time in milliseconds
  if vim.b.last_key and ((current_time - vim.b.last_key_time) <= config.time_window) then
    local action = ""
    if vim.fn.mode() == 't' then -- Check if we're in Terminal mode
      action = config.map_term[vim.b.last_key .. key] or ""
    else
      action = config.map_insert[vim.b.last_key .. key] or ""
    end

    if action ~= "" then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<BR>" .. action, true, true, true), "t")
      return ""
    end
  end
  vim.b.last_key = key
  vim.b.last_key_time = current_time
  return key
end

-- Setup function with user configuration
function M.setup(user_config)
  -- Extend default config with user config
  config = vim.tbl_deep_extend("force", config, user_config or {})

  -- Set up autocmd to reset last key and its time on insert enter
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      vim.b.last_key = nil
      vim.b.last_key_time = 0
    end,
  })

  -- Dynamic key mappings based on configuration, for both insert and terminal modes
  local modes = {'i', 't'}
  for _, mode in ipairs(modes) do
    for keys, _ in pairs(mode == 'i' and config.map_insert or config.map_term) do
      for i = 1, #keys do
        local key = keys:sub(i,i)
        vim.api.nvim_set_keymap(mode, key, string.format("v:lua.require'jkescape'.handle_key_press('%s')", key), {expr = true, noremap = true, silent = true})
      end
    end
  end
end

return M

