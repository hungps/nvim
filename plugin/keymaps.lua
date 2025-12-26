-- stylua: ignore start
vim.g.mapleader = " "

--- @param mode string|string[]
--- @param lhs string
--- @param rhs string|function
--- @param desc? string
--- @param opts? vim.keymap.set.Opts
_G.map = function(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend('keep', opts or {}, { noremap = true, desc = desc })
  vim.keymap.set(mode, lhs, rhs, opts)
end

map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], "better j", { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], "better k", { expr = true })

map("x", ".", ":norm .<CR>", "Dot repeat on visually selected lines")
map("x", "@", ":norm @q<CR>", "Macro on visually selected lines")

map("n", "dd", function() return vim.fn.getline("."):match("^%s*$") and '"_dd' or "dd" end, "Delete line without yanking empty", { expr = true })
map("n", "x", '"_x', "Delete single character without yanking")

map('x', '/', '<Esc>/\\%V', "Search within visual selection")

map({ "n", "x" }, "gy", '"+y', "Copy to system clipboard")
map("n", "gY", '"+yg_', "Copy line to system clipboard")
map("n", "gp", '"+p', "Paste from system clipboard")
map("x", "gp", '"+P', "Paste from system clipboard")
map({ "n", "x" }, "gP", '"+P', "Paste from system clipboard")

map({"i", "t"}, "<C-p>", "<C-r>0", "Paste within insert mode")

map("n", "<C-h>", "<C-w><C-h>", "Focus on left window")
map("n", "<C-l>", "<C-w><C-l>", "Focus on right window")
map("n", "<C-j>", "<C-w><C-j>", "Focus on lower window")
map("n", "<C-k>", "<C-w><C-k>", "Focus on upper window")

map("n", "<S-Left>", "<Cmd>vertical resize -2<CR>", "Decrease window width")
map("n", "<S-Down>", "<Cmd>resize -2<CR>", "Decrease window height")
map("n", "<S-Up>", "<Cmd>resize +2<CR>", "Increase window height")
map("n", "<S-Right>", "<Cmd>vertical resize +2<CR>", "Increase window width")

map("v", "H", "<gv", "Decrease indent")
map("v", "J", ":m '>+1<CR>gv=gv", "Move lines down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move lines up")
map("v", "L", ">gv", "Increase indent")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<Esc>", "<Cmd>noh<CR><Esc>", "Escape and clear hlsearch")

map("t", "<Esc><Esc>", "<c-\\><c-n>", "Escape terminal mode")

map("n", "<C-s>", "<Cmd>w<CR>", "Save")

map("n", "<Leader>qq", "<Cmd>qa<CR>", "Quit All")

map("n", "<leader>yr", "<cmd>let @+ = expand('%:~:.')<cr>", "File path")
