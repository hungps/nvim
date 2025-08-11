local trouble = require("trouble")

trouble.setup({
  auto_close = true,
  use_diagnostic_signs = true,
})

map("n", "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", "Diagnostics")
map("n", "<Leader>xb", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", "Buffer Diagnostics")
map("n", "<Leader>cs", "<Cmd>Trouble symbols toggle focus=false<CR>", "Symbols")
map("n", "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", "Location List")
map("n", "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", "Quickfix List")
