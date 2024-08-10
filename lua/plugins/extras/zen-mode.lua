return {
  {
    "folke/zen-mode.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        width = 120,
      },
    },
  },
}
