require("hungps.options")
require("hungps.keymaps")
require("hungps.autocmds")
require("hungps.lazy")

pcall(require, "hungps.local")

vim.cmd.colorscheme("catppuccin")
