local M = {}

M.opts = {
  length = 80,
  margin = 5,
  default_map = true,
  auto_update = true,
  user = "Diogo-ss",
  mail = "contact@diogosilva.dev",
  types = {
    [{ "c", "cc", "cpp", "cxx", "tpp", "glsl", "h", "hh", "hxx", "hpp", "php", "sql", "swift" }] = { "/*", "*", "*/" },
    [{ "css" }] = { "/*", "*", "*/" },
    [{ "go" }] = { "//", "*", "//" },
    [{ "lua", "hs" }] = { "--", "*", "--" },
    [{ "md", "htm", "html", "xml" }] = { "<!--", "*", "-->" },
    [{ "js", "ts", "rs", "java" }] = { "//", "*", "//" },
    [{ "tex" }] = { "%", "*", "%" },
    [{ "ml", "mli", "mll", "mly" }] = { "(*", "*", "*)" },
    [{ "vim", "vimrc" }] = { '"', "*", '"' },
    [{ "el", "asm", "s" }] = { ";", "*", ";" },
    [{ "emacs", "f90", "f95", "f03", "f" }] = { ";", "*", ";" },
    [{ "bat" }] = { "REM", "*", "REM" },
    [{ "vb" }] = { "'", "*", "'" },
    [{ "cob" }] = { "*", "*", "*" },
    [{ "scala", "dart" }] = { "//", "*", "//" },
    [{ "plsql", "vhdl" }] = { "--", "*", "--" },
  },
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
        local header = M.gen_header {}
        if M.has_header(M.remove_from(header, 4)) then
          M.update_header()
        end
      end,
    })
  end

  if M.opts.default_map == true then
    vim.keymap.set("n", "<F1>", ":Stdheader<CR>", { silent = true, noremap = true })
  end
end

function M.get_user()
  return vim.g.user or M.opts.user
end

function M.get_mail()
  return vim.g.mail or M.opts.mail
end

function M.remove_from(tbl, index)
for i = #tbl, index, -1 do
    table.remove(tbl, i)
end

  return tbl
end

M.get_symbols = function(filetype)
  for langs, value in pairs(M.opts.types) do
    for _, lang in pairs(langs) do
      if lang == filetype then
        return value[1], value[2], value[3]
      end
    end
  end

  return "#", "*", "#"
end

function M.ascii(n)
  return M.opts.asciiart[n - 2]
end

function M.textline(left, right)
  local start, _, _end = M.get_symbols(vim.bo.filetype)

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
  local start, fill, _end = M.get_symbols(vim.bo.filetype)

  if n == 1 or n == 11 then
    return start .. " " .. string.rep(fill, M.opts.length - string.len(start) - string.len(_end) - 2) .. " " .. _end
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

function M.has_header(header)
  local lines = vim.api.nvim_buf_get_lines(0, 0, #header, false)

  return vim.deep_equal(header, lines)
end

function M.gen_header(opts)
  local limit = opts.limit or 11
  local header = {}
  for i = 1, limit do
    table.insert(header, line(i))
  end
  return header
end

function M.insert_header()
  local header = M.gen_header {}
  table.insert(header, "")
  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function M.update_header()
  local header = M.gen_header {}
  header[8] = vim.api.nvim_buf_get_lines(0, 7, 8, false)[1]
  vim.api.nvim_buf_set_lines(0, 0, 11, false, header)
end

function M.stdheader()
  local header = M.gen_header {}
  if not M.has_header(header) then
    M.insert_header()
  else
    M.update_header()
  end
end

return M
