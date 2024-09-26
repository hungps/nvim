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
        { "<leader>f", group = "[F]ind" },
        { "<leader>c", group = "[C]ode", mode = { "n", "v" } },
        { "<leader>b", group = "[B]uffer" },
        { "<leader>g", group = "[G]it" },
        { "<leader>d", group = "[D]ebug" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>tn", "<cmd>set rnu!<CR>", group = "Relative [N]umber" },
        { "<leader>x", group = "[X]Diagnostics" },
        { "<leader>q", group = "[Q]uit" },
      },
    },
  },
}
