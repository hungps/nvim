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
      },
    },
    opts = {
      bigfile = { enabled = true },
      lazygit = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("snacks").rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  },
}
