local types = require "core.types"
local start = "/*"
local _end = "*/"
local fill = "*"

local M = {}

M.opts = {
  length = 80,
  margin = 5,
  default_map = true,
  auto_update = true,
  user = "Diogo-ss",
  mail = "contact@diogosilva.dev",
  asciiart = {
    "        :::      ::::::::",
    "      :+:      :+:    :+:",
    "    +:+ +:+         +:+  ",
    "  +#+  +:+       +#+     ",
    "+#+#+#+#+#+   +#+        ",
    "     #+#    #+#          ",
    "    ###   ########.fr    ",
  },
}

function M.setup(options)
  M.opts = vim.tbl_extend("force", M.opts, options or {})

  local custom = vim.api.nvim_create_augroup("custom_header_group", {})

  vim.api.nvim_create_user_command("Stdheader", M.stdheader, {})

  if M.opts.auto_update == true then
    vim.api.nvim_create_autocmd("BufWritePre", {
      nested = true,
      group = custom,
      callback = function()
        M.stdheader_auto()
      end,
    })
  end

  if M.opts.default_map == true then
    vim.keymap.set("n", "<F1>", ":Stdheader<CR>", { silent = true, noremap = true })
  end
end

local function get_user()
  return vim.g.user or M.opts.user
end

local function get_mail()
  return vim.g.mail or M.opts.mail
end

local function filetype()
  local f = vim.fn.expand "%:e"
  local values = types[f] or { "#", "#", "*" }
  start, _end, fill = values[1], values[2], values[3]
end

local function ascii(n)
  return M.opts.asciiart[n - 2]
end

local function textline(left, right)
  left = string.sub(left, 1, M.opts.length - M.opts.margin * 2 - string.len(right))

  return start
    .. string.rep(" ", M.opts.margin - string.len(start))
    .. left
    .. string.rep(" ", M.opts.length - M.opts.margin * 2 - string.len(left) - string.len(right))
    .. right
    .. string.rep(" ", M.opts.margin - string.len(_end))
    .. _end
end

local function line(n)
  if n == 1 or n == 11 then
    return start .. " " .. string.rep(fill, M.opts.length - string.len(start) - string.len(_end) - 2) .. " " .. _end
  elseif n == 2 or n == 10 then
    return textline("", "")
  elseif n == 3 or n == 5 or n == 7 then
    return textline("", ascii(n))
  elseif n == 4 then
    return textline(vim.fn.expand "%:t", ascii(n))
  elseif n == 6 then
    return textline("By: " .. get_user() .. " <" .. get_mail() .. ">", ascii(n))
  elseif n == 8 then
    return textline("Created: " .. os.date "%Y/%m/%d %H:%M:%S" .. " by " .. get_user(), ascii(n))
  elseif n == 9 then
    return textline("Updated: " .. os.date "%Y/%m/%d %H:%M:%S" .. " by " .. get_user(), ascii(n))
  end
end

local function has_header()
  local header = {}
  for i = 1, 3 do
    table.insert(header, line(i))
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, 3, false)
  for i, line in ipairs(header) do
    if lines[i] ~= line then
      return false
    end
  end
  return true
end

local function insert_header()
  local header = {}
  for i = 1, 11 do
    table.insert(header, line(i))
  end
  table.insert(header, "")
  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

local function update_header()
  local header = {}
  for i = 1, 11 do
    if i ~= 8 then
      table.insert(header, line(i))
    else
      table.insert(header, vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1])
    end
  end
  vim.api.nvim_buf_set_lines(0, 0, 11, false, header)
end

function M.stdheader()
  filetype()
  if not has_header() then
    insert_header()
  else
    update_header()
  end
end

function M.stdheader_auto()
  filetype()
  if has_header() then
    update_header()
  end
end

return M
