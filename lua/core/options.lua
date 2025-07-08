vim.g.mapleader = " "

vim.opt.laststatus = 3
vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.ruler = false
vim.opt.cursorline = true
vim.opt.signcolumn = "auto:1-3"
vim.opt.list = true
vim.opt.listchars = { extends = "…", precedes = "…", tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " ", fold = " " }
vim.opt.mouse = "a"
vim.opt.winborder = "single"
vim.opt.scrolloff = 10
vim.opt.conceallevel = 2
-- vim.opt.inccommand = "split"

vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = "menu,menuone"

vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 400
vim.opt.updatetime = 250 -- Required by CursorHold, CursorHoldI autocmds

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ""
