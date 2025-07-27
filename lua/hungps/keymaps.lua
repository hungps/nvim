local map = vim.keymap.set
local del = vim.keymap.del

map("n", "q:", "<nop>", { noremap = true })
map("n", ":Q", ":q")
map("n", ":W", ":w")

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and keep the cursor at the center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and keep the cursor at the center" })

map("n", "<S-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<S-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<S-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<S-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map({ "n", "v" }, "<", "<gv", { desc = "Decrease indent" })
map({ "n", "v" }, ">", ">gv", { desc = "Increase indent" })
del("s", "<")
del("s", ">")

map("n", "[t", "<cmd>tabp<CR>", { desc = "Go to prev tab" })
map("n", "]t", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "[e", function() vim.diagnostic.jump({ severity = "ERROR", count = -1, float = true }) end)
map("n", "]e", function() vim.diagnostic.jump({ severity = "ERROR", count = 1, float = true }) end)
map("n", "[w", function() vim.diagnostic.jump({ severity = "WARN", count = -1, float = true }) end)
map("n", "]w", function() vim.diagnostic.jump({ severity = "WARN", count = 1, float = true }) end)
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)

map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })
map("n", "<leader>tr", "<Cmd>set rnu!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>qq", "<Cmd>qa<CR>", { desc = "Quit All" })
