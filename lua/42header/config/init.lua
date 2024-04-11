local M = {}

M.opts = {
  length = 80,
  margin = 5,
  default_map = true,
  auto_update = true,
  user = "username",
  mail = "your@mail.com",
  asciiart = {
    "        :::      ::::::::",
    "      :+:      :+:    :+:",
    "    +:+ +:+         +:+  ",
    "  +#+  +:+       +#+     ",
    "+#+#+#+#+#+   +#+        ",
    "     #+#    #+#          ",
    "    ###   ########.fr    ",
  },
  git = {
    enabled = false,
    bin = "git",
    user_global = true,
    email_global = true,
  },
}

---Applies the user options to the default table.
---@param opts table: settings
M.set = function(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

return M
