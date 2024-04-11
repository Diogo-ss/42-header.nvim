local M = {}

M.opts = {
  --- Max header size (not recommended change).
  length = 80,
  --- Header margin (not recommended change).
  margin = 5,
  --- Activate default mapping (e.g. F1).
  default_map = true,
  --- Enable auto-update of headers.
  auto_update = true,
  --- Default user name.
  user = "username",
  --- Default user email.
  mail = "your@mail.com",
  --- ASCII art.
  asciiart = {
    "        :::      ::::::::",
    "      :+:      :+:    :+:",
    "    +:+ +:+         +:+  ",
    "  +#+  +:+       +#+     ",
    "+#+#+#+#+#+   +#+        ",
    "     #+#    #+#          ",
    "    ###   ########.fr    ",
  },
  --- Git config.
  git = {
    --- Enable Git support.
    enabled = true,
    --- PATH to the Git binary.
    bin = "git",
    --- Use global user.name, otherwise use local user.name.
    user_global = true,
    --- Use global user.email, otherwise use local user.email,
    email_global = true,
  },
}

---Applies the user options to the default table.
---@param opts table: settings
M.set = function(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

return M
