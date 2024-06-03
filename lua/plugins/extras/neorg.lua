return {
  {
    "nvim-neorg/neorg",
    version = "*",
    cmd = { "Neorg" },
    ft = "norg",
    dependencies = {
      { "vhyrro/luarocks.nvim", config = true },
    },
    opts = {
      configure_parsers = true,
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.esupports.metagen"] = {
          config = {
            author = "hungps",
            type = "auto",
            update_date = true,
          },
        },
        ["core.concealer"] = {},
        ["core.export"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Library/Mobile Documents/com~apple~CloudDocs/Notes",
            },
            default_workspace = "notes",
          },
        },
      },
    },
    config = function(_, opts)
      require("neorg").setup(opts)

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "norg" })
    end,
  },
}
