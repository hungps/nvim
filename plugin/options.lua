vim.o.undofile = true
vim.o.swapfile = false
vim.o.jumpoptions = ""

vim.o.mouse = "a"

vim.o.cursorline = true
vim.o.number = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.termguicolors = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showmode = false
vim.o.list = true
vim.o.listchars = "extends:…,precedes:…,tab:» ,trail:·,nbsp:␣,multispace:·,lead:·,eol:󱞣"
vim.o.conceallevel = 2
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.winborder = "single"
vim.o.signcolumn = "yes"
vim.o.fillchars = "eob: "

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

vim.o.updatetime = 250 -- Required by CursorHold autocmds
vim.o.timeoutlen = 200

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ""

vim.o.spell = true
vim.o.spelllang = "en_us,cjk"
vim.o.spelloptions = "camel"

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    severity_sort = true,
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "",
    },
    severity = { min = vim.diagnostic.severity.WARN },
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
