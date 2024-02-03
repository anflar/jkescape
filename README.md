This plugin maps jk/kj -> escape in insert mode without introducing lag.
I have no experience building plugins.
I'm a new NeoVim user.
Use at your own risk.

# Installing
## Using `lazy.nvim`
```lua
{"anflar/jkescape", config=true}
```

# Configuration
```lua
-- Default options:
require('jkescape').setup({
  time_window = 150, -- Adjust the time window as needed
  map_insert = {
    jk = '<BS><ESC>',
    kj = '<BS><ESC>',
  },
  map_term = {
    jk = '<BS><C-\\><C-n>',
    kj = '<BS><Up><CR>',
  },
})
```
