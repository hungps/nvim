local M = {}

M.border = function() return "│" end

M.signs = function() return vim.o.signcolumn and "%s" or " " end

M.number = function()
  local number_len = math.max(string.len(vim.fn.line(".")), 3)
  local number = vim.o.relativenumber and vim.v.relnum or vim.v.lnum

  if number == 0 then number = vim.v.lnum end

  return string.format("%" .. number_len .. "s ", number)
end

M.folds = function()
  if not vim.o.foldenable then return "" end

  local line = vim.v.lnum
  local first_line = vim.fn.line("^")
  local last_line = vim.fn.line("$")

  local foldsigns = function()
    local foldlevel = vim.fn.foldlevel(line)
    local foldclosed = vim.fn.foldclosed(line)
    local foldlevel_before = vim.fn.foldlevel(math.max(line - 1, first_line))
    local foldlevel_after = vim.fn.foldlevel(math.min(line + 1, last_line))

    if foldlevel == 0 then return " " end
    if foldclosed ~= -1 then return "▶" end
    if foldlevel > foldlevel_before then return "▽" end
    if foldlevel > foldlevel_after then return "╰" end
    return "╎"
  end

  return foldsigns()
end

M.statuscolumn = function()
  return table.concat({
    M.signs(),
    M.folds(),
    M.number(),
    M.border(),
  })
end

M.setup = function()
  _G.statuscolumn = M.statuscolumn
  vim.o.statuscolumn = "%!v:lua.statuscolumn()"
end

M.setup()
