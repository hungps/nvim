return {
  {
    "nvim-neorg/neorg",
    version = "*",
    build = ":Neorg sync-parsers",
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
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "norg" })
    end,
  },
}
