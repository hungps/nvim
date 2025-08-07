add("echasnovski/mini.pairs", function() require("mini.pairs").setup() end)
add("echasnovski/mini.comment", function() require("mini.comment").setup() end)
add("echasnovski/mini.move", function() require("mini.move").setup() end)
add("echasnovski/mini.align", function() require("mini.align").setup() end)
add("echasnovski/mini.splitjoin", function() require("mini.splitjoin").setup() end)

add("echasnovski/mini.surround", function()
  local surround = require("mini.surround")
  surround.setup({
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
      suffix_last = "l",
      suffix_next = "n",
    },
  })
end)

add("gbprod/substitute.nvim", function()
  local substitute = require("substitute")
  local range = require("substitute.range")
  local exchange = require("substitute.exchange")

  substitute.setup({
    range = {
      confirm = true,
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(ev)
      if ev.match == "fugitive" then return end

      map("n", "s", substitute.operator, "Substitute", { buffer = ev.buf })
      map("n", "ss", substitute.line, "Substitute line", { buffer = ev.buf })
      map("n", "S", substitute.eol, "Substitute to end of line", { buffer = ev.buf })
      map("x", "s", substitute.visual, "Substitute", { buffer = ev.buf })

      map("n", "sr", range.operator, "Substitute range", { buffer = ev.buf })
      map("n", "srs", range.word, "Substitute word", { buffer = ev.buf })
      map("x", "sr", range.visual, "Substitute", { buffer = ev.buf })

      map("n", "sx", exchange.operator, "Exchange", { buffer = ev.buf })
      map("n", "sxx", exchange.line, "Exchange line", { buffer = ev.buf })
      map("n", "sxc", exchange.cancel, "Cancel exchange", { buffer = ev.buf })
      map("x", "X", exchange.visual, "Exchange", { buffer = ev.buf })
    end,
  })
end)

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
