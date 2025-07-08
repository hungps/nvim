return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
    },
    opts = {
      linters = {},
      formatters = {},
      debuggers = {},
      servers = {},
    },
    config = function(_, opts)
      local packages = vim
        .iter({
          opts.linters,
          opts.formatters,
          opts.debuggers,
        })
        :flatten()
        :totable()

      require("mason").setup()
      require("mason-tool-installer").setup({ ensure_installed = packages })
      require("mason-lspconfig").setup({ ensure_installed = opts.servers })
    end,
  },
}
