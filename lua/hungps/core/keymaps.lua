--- @param mode string|string[]
--- @param lhs string
--- @param rhs string|function
--- @param desc? string
--- @param opts? vim.keymap.set.Opts
_G.map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc or opts.desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

--- @param name string
--- @param command string|fun(args: vim.api.keyset.create_user_command.command_args)
--- @param opts? vim.api.keyset.user_command
_G.command = function(name, command, opts) return vim.api.nvim_create_user_command(name, command, opts or {}) end

vim.g.mapleader = " "

map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], "better j", { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], "better k", { expr = true })
map({ "n", "x" }, "0", [[v:count == 0 ? 'g0' : '0']], "better 0", { expr = true })
map({ "n", "x" }, "^", [[v:count == 0 ? 'g^' : '^']], "better ^", { expr = true })
map({ "n", "x" }, "$", [[v:count == 0 ? 'g$' : '$']], "better $", { expr = true })

map({ "n", "x" }, "gy", '"+y', "Copy to system clipboard")
map({ "n", "x" }, "gY", '"+Y', "Copy line to system clipboard")
map("n", "gp", '"+p', "Paste from system clipboard")
map("x", "gp", '"+P', "Paste from system clipboard")
map({ "n", "x" }, "gP", '"+P', "Paste from system clipboard")

map("v", "/", "/\\%V", "Search inside visual selection")

map("n", "<C-h>", "<C-w><C-h>", "Focus on left window")
map("n", "<C-l>", "<C-w><C-l>", "Focus on right window")
map("n", "<C-j>", "<C-w><C-j>", "Focus on lower window")
map("n", "<C-k>", "<C-w><C-k>", "Focus on upper window")

map("n", "<S-Left>", "<Cmd>vertical resize -2<CR>", "Decrease window width")
map("n", "<S-Down>", "<Cmd>resize -2<CR>", "Decrease window height")
map("n", "<S-Up>", "<Cmd>resize +2<CR>", "Increase window height")
map("n", "<S-Right>", "<Cmd>vertical resize +2<CR>", "Increase window width")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<Esc>", "<Cmd>noh<CR><Esc>", "Escape and clear hlsearch")

map("n", "<Leader>qq", "<Cmd>qa<CR>", "Quit All")
