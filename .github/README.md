<h1 align="center">🛸 42 Header</h1>

This plugin is whole re-write of [42header](https://github.com/42Paris/42header) in Lua.

## ✨ Features
- Command: `Stdheader`
- Customizable options
- Modulate
- Auto update on save (optional)
- Support many [file types](https://github.com/Diogo-ss/42-header.nvim/blob/main/lua/42header/config/init.lua) by default

## 🚀 Showcase

![header](https://raw.githubusercontent.com/Diogo-ss/42-header.nvim/7528c7ff25c51bf32301dfc1ece995128d2ae7d5/.github/header_img.png)

## 🎈 Setup

### 📦 Packer.nvim
```lua
use { "Diogo-ss/42-header.nvim" }
```

### 💤 Lazy.nvim
```lua
{ "Diogo-ss/42-header.nvim" }
```
```lua
{
    "Diogo-ss/42-header.nvim",
    lazy = false,
    config = function()
        local header = require("42header")
        header.setup({
            default_map = true, -- default Mapping <F1> in normal mode
            auto_update = true,  -- update header when saving
            user = "Diogo-ss", -- your user
            mail = "contact@diogosilva.dev", -- your mail
        })
    end
}
```

### 🔌 Vim-plug 
```lua
call plug#begin()
  Plug 'Diogo-ss/42-header.nvim'
call plug#end()
```

## ⚙ Options
```lua
local header = require("42header")
header.setup({
  length = 80, -- headers of different sizes are incompatible with each other
  margin = 5,
  default_map = true, -- default Mapping <F1> in normal mode
  auto_update = true, -- update header when saving
  user = "Diogo-ss", -- your user
  mail = "contact@diogosilva.dev", -- your mail
  -- asciiart = { "......", "......",} -- headers with different ascii arts are incompatible with each other
})
```

## 🌐 User and Mail
`user` and `mail` can be defined using global variables.
```lua
vim.g.user = "Diogo-ss"
vim.g.mail = "contact@diogosilva.dev"
```
> **_NOTE:_** global variables have higher priority than setup values

## 🍦 Credits
Lua version by [Diogo-ss](https://github.com/Diogo-ss)

Original VimScript version:
<br>
[zazard](https://github.com/zazard) - creator  
[alexandregv](https://github.com/alexandregv) - contributor  
[mjacq42](https://github.com/mjacq42) - contributor  
[sungmcho](https://github.com/lordtomi0325) - contributor  


