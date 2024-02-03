local jk_escape = require('jk_escape.init')

jk_escape.setup = function()
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      vim.b.last_key = nil
      vim.b.last_key_time = 0
    end,
  })

  vim.api.nvim_set_keymap('i', 'j', "v:lua.require'jk_escape'.handle_key_press('j')", {expr = true, noremap = true, silent = true})
  vim.api.nvim_set_keymap('i', 'k', "v:lua.require'jk_escape'.handle_key_press('k')", {expr = true, noremap = true, silent = true})
end

return jk_escape
