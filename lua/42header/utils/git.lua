---@tag 42header.git

---@brief [[
---
--- This module adds Git support.
---
---@brief ]]

local config = require "42header.config"

local M = {}

---Executes a Git command and returns the output.
---@param ... table: Arguments.
---@return string|nil: Output of command, or nil if the command fails or returns an empty output.
function M.cmd(...)
  local output = vim.trim(vim.fn.system { config.opts.git.bin, unpack(...) })

  if vim.v.shell_error ~= 0 or output == "" then
    return nil
  end

  return output
end

---Get user.name.
---@return string|nil
function M.user()
  local flag = config.opts.git.user_global and "--global" or "--local"
  return M.cmd { "config", flag, "--includes", "user.name" }
end

---Get user.email.
---@return string|nil
function M.email()
  local flag = config.opts.git.email_global and "--global" or "--local"
  return M.cmd { "config", flag, "--includes", "user.email" }
end

return M
