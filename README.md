This plugin maps jk/kj -> escape in insert mode without introducing lag.
I have no experience building plugins.
I'm a new NeoVim user.
Use at your own risk.

# Installing
## Using `lazy.nvim`
```lua
{"anflar/jkescape", config=true}
```

# Configuration default
```lua
{"anflar/jkescape", config=true, opts = {
  time_window = 150, -- ms 
  map_insert = {
    jk = '<ESC>',
    kj = '<ESC>',
  },
  map_term = {
    jk = '<C-\\><C-n>',
    kj = '<Up><CR>',
  },
}},
```
