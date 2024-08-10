return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason-lspconfig.nvim",
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
