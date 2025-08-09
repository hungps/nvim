local conform = require("conform")

conform.setup({
  formatters_by_ft = Config.formatters_by_ft,
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = { lsp_format = "fallback" },
  notify_no_formatters = false,
})

map("n", "<Leader>cf", function() conform.format({ lsp_fallback = true }) end, "Format")
