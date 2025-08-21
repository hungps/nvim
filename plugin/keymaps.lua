-- stylua: ignore start
vim.g.mapleader = " "

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

map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], "better j", { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], "better k", { expr = true })
map({ "n", "x" }, "0", [[v:count == 0 ? "g0" : "0"]], "better 0", { expr = true })
map({ "n", "x" }, "^", [[v:count == 0 ? "g^" : "^"]], "better ^", { expr = true })
map({ "n", "x" }, "$", [[v:count == 0 ? "g$" : "$"]], "better $", { expr = true })

map("x", ".", "<Cmd>norm .<CR>", "Dot repeat on visually selected lines")
map("x", "@", "<Cmd>norm @q<CR>", "Macro on visually selected lines")

map("n", "dd", function() return vim.fn.getline("."):match("^%s*$") and '"_dd' or "dd" end, "Delete line without yanking empty", { expr = true })

-- no vim.o.clipboard = "unnamedplus"
map({ "n", "x" }, "gy", '"+y', "Copy to system clipboard")
map({ "n", "x" }, "gY", '"+Y', "Copy line to system clipboard")
map("n", "gp", '"+p', "Paste from system clipboard")
map("x", "gp", '"+P', "Paste from system clipboard")

map("v", "/", "/\\%V", "Search inside visual selection")

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

map("n", "J", "mzJ`z", "Keep cursor after joining lines")

map("n", "<Esc>", "<Cmd>noh<CR><Esc>", "Escape and clear hlsearch")

map("t", "<Esc><Esc>", "<c-\\><c-n>", "Escape terminal mode")

map("n", "<C-s>", "<Cmd>w<CR>", "Save")


map("n", "<Leader>qq", "<Cmd>qa<CR>", "Quit All")

-- Optional mappings:
map("n", "<Leader>tt", "<Cmd>15split | term<CR>", "Toggle terminal")

map("n", "<Leader>bo", "<Cmd>BufCloseHidden<CR>", "Close hidden buffers")
map("n", "<Leader>ts", "<Cmd>new | Scratch<CR>", "Open scratch buffer in slit")
map("n", "<Leader>tS", "<Cmd>vnew | Scratch<CR>", "Open scratch buffer in vslit")

map("n", "<Leader>sn", ":g//norm <left><left><left><left><left>", "Search and do in normal mode")
map("x", "<Leader>sn", '"hy:g/<C-r>h/norm ', "Search visually selected text and do in normal mode")

map("n", "<Leader>sr", "<nop>", "+Replace")
map("n", "<Leader>srr", ":s///gc<left><left><left><left>", "Replace in line")
map("x", "<Leader>srr", ":s///gc<left><left><left><left>", "Replace in visually selected lines")
map("n", "<Leader>srR", ":%s///gcI<left><left><left><left><left>", "Replace (buffer)")
map("x", "<Leader>srR", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', "Replace selected text (buffer)")

map("x", "<Leader>sry", ':s/<C-r>*/<C-r>*/gc<left><left><left>', "Replace yanked word")
map("n", "<Leader>sry", ':%s/<C-r>*/<C-r>*/gc<left><left><left>', "Replace yanked word (buffer)")

map("n", "<Leader>srw", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left>", "Replace word under cursor")
map("n", "<Leader>srW", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left>", "Replace word under cursor (buffer)")
