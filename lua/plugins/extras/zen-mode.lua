return {
  {
    "folke/zen-mode.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>tz", "<cmd>ZenMode<cr>", desc = "[Z]en Mode" },
    },
    opts = {
      window = {
        width = 120,
      },
    },
  },
}
