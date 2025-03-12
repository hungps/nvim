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
        { "<leader>a", group = "[A]I assistant" },
        { "<leader>b", group = "[B]uffer" },
        { "<leader>c", group = "[C]ode", mode = { "n", "v" } },
        { "<leader>d", group = "[D]ebug" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>g", group = "[G]it" },
        { "<leader>q", group = "[Q]uit" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>x", group = "[X]Diagnostics" },
        { "<leader>tr", "<cmd>set rnu!<CR>", desc = "[R]elative number" },
      },
    },
  },
}
