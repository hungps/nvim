local opt = vim.opt

vim.g.mapleader = " "

opt.termguicolors = true
opt.laststatus = 3

opt.showmode = false
-- opt.cmdheight = 0
opt.showcmd = false
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.ruler = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.list = true
opt.mouse = "a"

opt.wildmode = "longest:full,full"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2

opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400

opt.confirm = true
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000

opt.timeoutlen = 400
opt.updatetime = 250

opt.inccommand = "split"

opt.scrolloff = 10
opt.pumblend = 10
opt.pumheight = 10
