return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>gg",
        function()
          require("snacks").lazygit.open()
        end,
        desc = "Lazy[G]it",
      },
      {
        "<leader>bd",
        function()
          require("snacks").bufdelete.delete()
        end,
        desc = "Close [C]urrent Buffer",
      },
      {
        "<leader>bo",
        function()
          require("snacks").bufdelete.other()
        end,
        desc = "Close [O]ther Buffer",
      },
    },
    opts = {
      dashboard = { enabled = true },
      bigfile = { enabled = true },
      lazygit = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      words = { enabled = true },
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("snacks").rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  },
}
