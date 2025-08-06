add("echasnovski/mini.pairs", function() require("mini.pairs").setup() end)
add("echasnovski/mini.surround", function() require("mini.surround").setup() end)
add("echasnovski/mini.comment", function() require("mini.comment").setup() end)
add("echasnovski/mini.move", function() require("mini.move").setup() end)
add("echasnovski/mini.align", function() require("mini.align").setup() end)
add("echasnovski/mini.splitjoin", function() require("mini.splitjoin").setup() end)

add("stevearc/conform.nvim", function()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = Config.formatters_by_ft,
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { lsp_format = "fallback" },
    notify_no_formatters = false,
  })

  map("n", "<Leader>cf", function() conform.format({ lsp_fallback = true }) end, "Format")
end)

add("mfussenegger/nvim-lint", function()
  local lint = require("lint")

  lint.linters_by_ft = Config.linters_by_ft

  local try_lint = function() lint.try_lint(nil, { ignore_errors = true }) end

  map("n", "<Leader>cl", try_lint, "Lint")

  autocmd("Auto lint on save", augroup("LintOnSave"), { "BufWritePost" }, "*", try_lint)
end)
