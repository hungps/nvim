return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "TodoTelescope",
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search [T]odo" },
    },
    opts = {
      signs = false,
    },
  },
}
