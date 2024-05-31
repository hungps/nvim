return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Diagnostics in [D]ocument" },
      { "<leader>tD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Diagnostics in [W]orkspace" },
      { "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "[L]ocation List" },
      { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "[Q]uickfix List" },
    },
  },
}
