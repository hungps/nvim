return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    -- stylua: ignore
    keys = {
      { "<leader>cf", function() require("conform").format { lsp_fallback = true } end, desc = "[F]ormat" },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "InsertEnter",
    version = "*",
    keys = {
      { "<leader>cs", desc = "[S]urround", mode = { "n", "v" } },
    },
    opts = {
      mappings = {
        add = "<leader>csa",
        delete = "<leader>csd",
        find = "<leader>csf",
        find_left = "<leader>csF",
        highlight = "<leader>csh",
        replace = "<leader>csr",
        update_n_lines = "<leader>csn",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    version = "*",
    opts = {},
  },
}
