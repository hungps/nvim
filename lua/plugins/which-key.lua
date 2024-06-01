return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require "which-key"
      wk.setup()

      wk.register({
        ["<leader>f"] = "[F]ind",
        ["<leader>s"] = "[S]earch",
        ["<leader>c"] = "[C]ode",
        ["<leader>b"] = "[B]uffer",
        ["<leader>g"] = "[G]it",
        ["<leader>d"] = "[D]ebug",
        ["<leader>t"] = "[T]oggle",
        ["<leader>tn"] = { "<cmd>set rnu!<CR>", "Toggle relative [N]umber" },
        ["<leader>x"] = "[X]Diagnostics",
        ["<leader>q"] = "[Q]uit",
      }, { mode = "n" })

      wk.register({
        ["<leader>c"] = "[C]ode",
      }, { mode = "v" })
    end,
  },
}
