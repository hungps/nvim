return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    opts = {
      jump = {
        nohlsearch = true,
        autojump = true,
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          autohide = true,
          jump_labels = true,
        },
      },
    },
  },
}
