return {
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "dart-debug-adapter",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "dart",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        dartls = {},
      },
    },
  },
}
