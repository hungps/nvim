vim.o.undofile = true
vim.o.swapfile = false
vim.o.jumpoptions = ""

vim.o.mouse = "a"
vim.o.switchbuf = "usetab"

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"
vim.o.number = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.termguicolors = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.showmode = false
vim.o.list = true
vim.o.conceallevel = 2
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.winborder = "single"
vim.o.signcolumn = "yes"
vim.o.fillchars = "eob: ,fold:╌"
vim.o.listchars = "extends:…,precedes:…,tab:» ,trail:·,nbsp:␣,multispace:·,lead:·,eol: " -- eol:󱞣

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.smartindent = true

vim.o.wildmode = "longest:full,full"
vim.o.completeopt = "menu,menuone"

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.formatoptions = "rqnl1j"
vim.o.spelloptions = "camel"
vim.o.virtualedit = "block"
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.updatetime = 250 -- Required by CursorHold autocmds
vim.o.timeoutlen = 200

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ""

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    severity_sort = true,
    source = true,
  },
  underline = {
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  signs = {
    priority = 9999,
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "",
    },
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },
})

-- make :W, :Q, etc. works!
vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qa! qa!
  cnoreabbrev Wa wa
  cnoreabbrev Wq wq
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qa qa
  cnoreabbrev Vs vs
  cnoreabbrev vS vs
  cnoreabbrev VS vs
]])
