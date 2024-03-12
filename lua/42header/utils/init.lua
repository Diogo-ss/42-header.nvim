--- Module for managing and generating header comments in code files.
-- generate ASCII art, create formatted header lines, check for the existence of a header,
-- generate a complete header, insert or update headers.
local M = {}
local config = require "42header.config"

--- Get the user name.
-- @return The global user name or configuration.
function M.get_user()
  return vim.g.user or config.opts.user
end

--- Get the user mail.
-- @return The global user mail or configuration.
function M.get_mail()
  return vim.g.mail or config.opts.mail
end

--- Get symbols (e.g., comment characters) for a specified file type.
-- @param filetype The file type for which symbols are retrieved.
-- @return Symbols for the specified file type.
function M.get_symbols(filetype)
  for langs, value in pairs(config.opts.types) do
    for _, lang in pairs(langs) do
      if lang == filetype then
        return unpack(value)
      end
    end
  end

  return "#", "*", "#"
end

--- Get an ASCII art element based on an index.
-- @param n The index of the ASCII art element to retrieve.
-- @return The ASCII art element.
function M.ascii(n)
  -- Subtracts 2 from `n` to adjust for the margin of two additional lines at the top of the header.
  return config.opts.asciiart[n - 2]
end

--- Create a formatted text line for the header.
-- @param left The left part of the header line.
-- @param right The right part of the header line.
-- @return The formatted header line.
function M.textline(left, right)
  local start, _, _end = M.get_symbols(vim.fn.expand "%:e")

  left = string.sub(left, 1, config.opts.length - config.opts.margin * 2 - string.len(right))

  return start
    .. string.rep(" ", config.opts.margin - string.len(start))
    .. left
    .. string.rep(" ", config.opts.length - config.opts.margin * 2 - string.len(left) - string.len(right))
    .. right
    .. string.rep(" ", config.opts.margin - string.len(_end))
    .. _end
end

--- Generate a specific line of the header based on the line number.
-- This function constructs a header line based on the provided line number `n` in the header.
-- @param n The line number for which to generate the header line.
-- @return A formatted header line based on the line number `n`.
function M.line(n)
  local start, fill, _end = M.get_symbols(vim.fn.expand "%:e")

  if n == 1 or n == 11 then
    return start
      .. " "
      .. string.rep(fill, config.opts.length - string.len(start) - string.len(_end) - 2)
      .. " "
      .. _end
  elseif n == 2 or n == 10 then
    return M.textline("", "")
  elseif n == 3 or n == 5 or n == 7 then
    return M.textline("", M.ascii(n))
  elseif n == 4 then
    return M.textline(vim.fn.expand "%:t", M.ascii(n))
  elseif n == 6 then
    return M.textline("By: " .. M.get_user() .. " <" .. M.get_mail() .. ">", M.ascii(n))
  elseif n == 8 then
    return M.textline("Created: " .. os.date "%Y/%m/%d %H:%M:%S" .. " by " .. M.get_user(), M.ascii(n))
  elseif n == 9 then
    return M.textline("Updated: " .. os.date "%Y/%m/%d %H:%M:%S" .. " by " .. M.get_user(), M.ascii(n))
  end
end

--- Check if a header already exists in the current buffer.
-- @param header The header to compare against the existing buffer content.
-- @return `true` if the header exists, `false` otherwise.
function M.has_header(header)
  local lines = vim.api.nvim_buf_get_lines(0, 0, 11, false)

  -- immutable lines that are used for checking
  for _, v in pairs { 1, 2, 3, 10, 11 } do
    if header[v] ~= lines[v] then
      return false
    end
  end

  return true
end

--- Generate a complete header.
-- @return A table containing all lines of the generated header.
function M.gen_header()
  local header = {}
  for i = 1, 11 do
    table.insert(header, M.line(i))
  end
  return header
end

--- Insert a header into the current buffer.
-- @param header The header to insert.
function M.insert_header(header)
  -- If the first line is not empty, the blank line will be added after the header.
  if vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] ~= "" then
    table.insert(header, "")
  end

  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

--- Update an existing header in the current buffer.
-- @param header The updated header to replace the existing one.
function M.update_header(header)
  local immutable = { 6, 8 }

  -- Copies immutable lines from existing header to updated header.
  for _, value in ipairs(immutable) do
    header[value] = vim.api.nvim_buf_get_lines(0, value - 1, value, false)[1]
  end

  vim.api.nvim_buf_set_lines(0, 0, 11, false, header)
end

--- Standardize the header in the current buffer.
-- Inserts or updates the header based on its presence.
function M.stdheader()
  local header = M.gen_header()
  if not M.has_header(header) then
    M.insert_header(header)
  else
    M.update_header(header)
  end
end

return M
