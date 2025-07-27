return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "ruby")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        ruby_lsp = {},
      },
    },
  },
}
