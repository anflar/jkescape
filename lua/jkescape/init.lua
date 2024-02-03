local M = {}

function M.handle_key_press(key)
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

return M

