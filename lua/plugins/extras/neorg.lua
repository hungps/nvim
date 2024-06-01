return {
  {
    "nvim-neorg/neorg",
    dependencies = {
      { "vhyrro/luarocks.nvim", config = true },
    },
    ft = "norg",
    version = "*",
    cmd = { "Neorg" },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
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
}
