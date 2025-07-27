return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ lsp_fallback = true }) end,
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {},
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = { lsp_format = "fallback" },
      notify_no_formatters = false,
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {},
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        desc = "Lint on save",
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function() require("lint").try_lint(nil, { ignore_errors = true }) end,
      })
    end,
  },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "echasnovski/mini.splitjoin", opts = {} },
}
