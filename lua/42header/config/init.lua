--- Module for managing configuration options for the 42header plugin.
-- This module defines default configuration options and allows users to set custom options.
local M = {}

--- Default configuration options for the 42header plugin.
-- Users can customize these options by setting their own values.
-- @field length (number) The maximum line length for the header.
-- @field margin (number) The margin size.
-- @field default_map (boolean) Whether to enable the default key mapping.
-- @field auto_update (boolean) Whether to enable automatic header updates on file save.
-- @field types (table) A table mapping file extensions to their corresponding comment symbols.
--   - Each entry consists of a table of file extensions and a table of comment symbols.
--   - The comment symbols include the start, fill, and end symbols.
-- @field asciiart (table) A table containing ASCII art lines for the header decoration.
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
    bin = "git",
    enabled = true,
    email_global = true,
    user_global = true,
  },
}

--- Set custom configuration options.
-- @param opts (table) A table of custom configuration options to override the defaults.
M.set = function(opts)
  M.opts = opts
end

return M
