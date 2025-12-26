-- require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.align").setup()

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
map("n", "gs", "<nop>", "+Surround")

local conform = require("conform")
conform.setup({
  formatters_by_ft = Config.formatters_by_ft,
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = { lsp_format = "fallback" },
  notify_no_formatters = false,
})

map("n", "<Leader>cf", function() conform.format({ lsp_fallback = true }) end, "Format")

local lint = require("lint")
lint.linters_by_ft = Config.linters_by_ft

local try_lint = function() lint.try_lint(nil, { ignore_errors = true }) end

map("n", "<Leader>cl", try_lint, "Lint")

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
  pattern = "*",
  callback = try_lint,
})
