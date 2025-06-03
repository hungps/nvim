return {
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    dependencies = {
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    },
    opts = {
      linters = {},
      formatters = {},
      debuggers = {},
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
    end,
  },
}
