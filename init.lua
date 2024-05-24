require "core.options"
require "core.keymaps"
require "core.autocmds"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "plugins.extras" },
    { import = "plugins.lang" },
  },
  checker = {
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "onedark", "catppuccin" },
  },
}
