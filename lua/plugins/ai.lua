return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-c>",
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-e>",
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      {
        "<leader>ac",
        "<Cmd>CodeCompanionChat<CR>",
        desc = "[C]hat",
      },
      {
        "<leader>aa",
        "<Cmd>CodeCompanionActions<CR>",
        desc = "[A]ctions",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({ prompt = "Quick Chat: " }, function(input)
            if input then
              vim.cmd("'<,'>CodeCompanion " .. input)
            end
          end)
        end,
        desc = "[Q]uick ask",
        mode = "v",
      },
    },
    config = {},
  },
}
