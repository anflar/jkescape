-- /lua/jk_escape.lua
local M = {}

local function handle_key_press(key)
  local current_time = vim.loop.now() -- Current time in milliseconds
  if vim.b.last_key and ((current_time - vim.b.last_key_time) <= 100) then
    if (vim.b.last_key == "j" and key == "k") or (vim.b.last_key == "k" and key == "j") then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<BS><Esc>", true, true, true), "n")
      return ""
    end
  end
  vim.b.last_key = key
  vim.b.last_key_time = current_time
  return key
end

function M.setup()
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      vim.b.last_key = nil
      vim.b.last_key_time = 0
    end,
  })

  -- Setup key mappings to use the local function without setting it globally
  vim.api.nvim_set_keymap('i', 'j', "v:lua.require'jk_escape'.handle_j()", {expr = true, noremap = true, silent = true})
  vim.api.nvim_set_keymap('i', 'k', "v:lua.require'jk_escape'.handle_k()", {expr = true, noremap = true, silent = true})
end

-- Expose handlers for 'j' and 'k' to be used in key mappings
function M.handle_j()
  return handle_key_press('j')
end

function M.handle_k()
  return handle_key_press('k')
end

return M

