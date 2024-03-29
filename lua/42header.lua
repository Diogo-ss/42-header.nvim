local M = {}
local config = require "42header.config"
local utils = require "42header.utils"

function M.setup(options)
  local custom = vim.api.nvim_create_augroup("custom_header_group", {})

  config.set(vim.tbl_extend("force", config.opts, options or {}))
  vim.api.nvim_create_user_command("Stdheader", utils.stdheader, {})

  if config.opts.auto_update == true then
    vim.api.nvim_create_autocmd("BufWritePre", {
      nested = true,
      group = custom,
      callback = function()
        local header = utils.gen_header()
        if utils.has_header(header) then
          utils.update_header(header)
        end
      end,
    })
  end

  if config.opts.default_map == true then
    vim.keymap.set("n", "<F1>", ":Stdheader<CR>", { silent = true, noremap = true })
  end
end

return M
