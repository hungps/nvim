local map = vim.keymap.set

map("n", "q:", "<nop>", { noremap = true })

map("o", "ie", "<Cmd><C-u>normal! mzggVG<CR>`z", { desc = "Textobject to select entire buffer" })
map("x", "ie", "<Cmd><C-u>normal! ggVG<CR>`z", { desc = "Textobject to select entire buffer" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map({ "i", "c" }, "<C-b>", "<Esc>^i", { desc = "Move to the beginning of line" })
map({ "i", "c" }, "<C-e>", "<End>", { desc = "Move to the end of line" })
map({ "i", "c" }, "<C-h>", "<Left>", { desc = "Move left" })
map({ "i", "c" }, "<C-l>", "<Right>", { desc = "Move right" })
map({ "i", "c" }, "<C-j>", "<Down>", { desc = "Move down" })
map({ "i", "c" }, "<C-k>", "<Up>", { desc = "Move up" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and keep the cursor at the center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and keep the cursor at the center" })

map({ "i", "x", "n", "s" }, "<C-s>", "<Cmd>w<CR><Esc>", { desc = "Save File", noremap = true })
map({ "i", "x", "n", "s" }, "<CS-s>", "<Cmd>noautocmd w<CR><Esc>", { desc = "Save File (noautocmd)", noremap = true })

map("n", "<S-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<S-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<S-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<S-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

map("n", "ga;", "mzA;<Esc>`z", { desc = "Add ; to the end of the line" })
map("n", "ga,", "mzA,<Esc>`z", { desc = "Add , to the end of the line" })

-- Move Lines
map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move Down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move Up" })
map("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Buffer mapping
map("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<Cmd>:bd<CR>", { desc = "Close Buffer" })
map("n", "<leader>bo", "<Cmd>:w|%bd|e#|bd#<CR>", { desc = "Close Other Buffer" })

map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map("v", "<", "<gv", { desc = "Decrease indent" })
map("v", ">", ">gv", { desc = "Increase indent" })

map("n", "<leader>qq", "<Cmd>qa<CR>", { desc = "Quit All" })
