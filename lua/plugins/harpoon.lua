return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local h = require "harpoon"

      -- stylua: ignore
      return {
        { "<leader>h", desc = "[H]arpoon" },
        { "<leader>hl", function() h.ui:toggle_quick_menu(h:list()) end, desc = "[L]ist" },
        { "<leader>ha", function() h:list():add() end, desc = "[A]dd to list" },
        { "<leader>hc", function() h:list():clear() end, desc = "[C]lear all" },
        { "<S-h>", function() h:list():prev() end, desc = "Previous harpoon item" },
        { "<S-l>", function() h:list():next() end, desc = "Next harpoon item" },
      }
    end,
    config = function()
      require("harpoon"):setup {
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      }
    end,
  },
}
