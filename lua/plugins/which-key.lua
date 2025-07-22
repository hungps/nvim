return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = {
        mappings = false,
      },
      spec = {
        { "<leader>a", group = "AI" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code", mode = { "n", "v" } },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>q", group = "Quit" },
        { "<leader>t", group = "Toggle" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>tr", "<cmd>set rnu!<CR>", desc = "Relative number" },
      },
    },
  },
}
