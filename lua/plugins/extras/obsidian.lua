return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    cmd = { "ObsidianNew", "ObsidianTemplate", "ObsidianSearch", "ObsidianWorkspace" },
    event = {
      "BufReadPre '" .. vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md'",
      "BufNewFile '" .. vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md'",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "hungps",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/HungPS",
        },
      },
      notes_subdir = "Notes",
      new_notes_location = "notes_subdir",
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
    end,
  },
}
