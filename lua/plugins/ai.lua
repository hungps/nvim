return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
      {
        "<leader>at",
        function() require("copilot.suggestion").toggle_auto_trigger() end,
        desc = "[T]oggle autocomplete",
      },
    },
    opts = {
      filetypes = {
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
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
            if input then vim.cmd("'<,'>CodeCompanion " .. input) end
          end)
        end,
        desc = "[Q]uick ask",
        mode = "v",
      },
    },
    config = {},
  },
}
