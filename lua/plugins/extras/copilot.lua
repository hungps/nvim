return {
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-Space>", "<Plug>(copilot-suggest)")
      vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-y>", "copilot#Accept('')", { expr = true, replace_keycodes = false, silent = true })

      vim.keymap.set("i", "<C-c>", function()
        if require("cmp").visible() then
          require("cmp").abort()
        end

        return vim.fn["copilot#Accept"]("")
      end, { expr = true, replace_keycodes = false, silent = true })

      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function()
      require("which-key").add({
        { "<leader>a", desc = "[A]I assistant" },
      })
    end,
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
        mode = "n",
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({ prompt = "Quick Chat: " }, function(input)
            if input ~= "" then
              vim.cmd("'<,'>CodeCompanion " .. input)
            end
          end)
        end,
        desc = "[Q]uick ask",
        mode = "v",
      },
      {
        "<leader>aa",
        "<Cmd>CodeCompanionActions<CR>",
        desc = "[A]ctions",
        mode = { "n", "v" },
      },
    },
    config = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = function(_, opts)
      opts.file_types = opts.file_types or {}
      table.insert(opts.file_types, "codecompanion")
    end,
  },
}
