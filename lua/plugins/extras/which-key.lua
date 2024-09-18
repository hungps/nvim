return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = {
        mappings = false,
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        { "<leader>f", desc = "[F]ind" },
        { "<leader>c", desc = "[C]ode", mode = { "n", "v" } },
        { "<leader>b", desc = "[B]uffer" },
        { "<leader>g", desc = "[G]it" },
        { "<leader>d", desc = "[D]ebug" },
        { "<leader>t", desc = "[T]oggle" },
        { "<leader>tn", "<cmd>set rnu!<CR>", desc = "Toggle relative [N]umber" },
        { "<leader>x", desc = "[X]Diagnostics" },
        { "<leader>q", desc = "[Q]uit" },
      })
    end,
  },
}
