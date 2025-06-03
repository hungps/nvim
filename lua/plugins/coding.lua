return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ lsp_fallback = true }) end,
        desc = "[F]ormat",
      },
    },
    opts = {
      formatters_by_ft = {},
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
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
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function() require("lint").try_lint(nil, { ignore_errors = true }) end,
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
