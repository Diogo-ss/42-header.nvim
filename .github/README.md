<h1 align="center">🛸 42 Header</h1>

This plugin is whole re-write of [42header](https://github.com/42Paris/42header) in Lua.

## ✨ Features
- Customizable options
- Modulate
- Auto Update (optional)
- 34 [langs](https://github.com/Diogo-ss/42-header.nvim/blob/main/lua/core/types.lua) support by default

## Showcase

![header](https://github.com/Diogo-ss/42-header.nvim/blob/main/.github/header_img.png)

## 🎈 Setup

### 📦 Packer.nvim
```lua
use { "Diogo-ss/42-header.nvim" }
```

### 💤 Lazy.nvim
```lua
{ "Diogo-ss/42-header.nvim" }
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
    default_map = true, -- Update header when saving
    auto_update = true  -- Default Mapping <F1> in normal mode
})
```

## 🌐 User and Mail
Priority Order: First global variables and then environmental variables.

#### `USER` and `MAIL` can be defined in two ways:

**Option 1:** Set `USER` and `MAIL` values directly in your `init.lua`:
```lua
vim.g.user = "Diogo-ss"
vim.g.mail = "diogo-ss@mail.com"
```

**Option 2:** Export `USER` and `MAIL` in your environment variables:
- `USER`
- `MAIL`

## 🍦 Credits
Lua version by [Diogo-ss](https://github.com/Diogo-ss)

Original VimScript version:
<br>
[zazard](https://github.com/zazard) - creator  
[alexandregv](https://github.com/alexandregv) - contributor  
[mjacq42](https://github.com/mjacq42) - contributor  
[sungmcho](https://github.com/lordtomi0325) - contributor  

