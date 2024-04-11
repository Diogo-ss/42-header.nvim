local config = require "42header.config"

local M = {}

function M.cmd(...)
  local output = vim.trim(vim.fn.system { config.opts.git.bin, unpack(...) })

  if vim.v.shell_error ~= 0 or output == "" then
    return nil
  end

  return output
end

function M.user()
  local flag = config.opts.git.user_global and "--global" or "--local"
  return M.cmd { "config", flag, "user.name" }
end

function M.email()
  local flag = config.opts.git.user_global and "--global" or "--local"
  return M.cmd { "config", flag, "user.email" }
end

return M
