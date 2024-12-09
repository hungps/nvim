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
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    build = "make tiktoken",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {
          file_types = { "markdown", "copilot-chat" },
        },
      },
    },
    keys = function()
      local chat = require("CopilotChat")
      local actions = require("CopilotChat.actions")
      local selection = require("CopilotChat.select").visual

      return {
        {
          "<leader>ac",
          function()
            chat.toggle()
          end,
          desc = "[C]hat",
          mode = "n",
        },
        {
          "<leader>aq",
          function()
            vim.ui.input({ prompt = "Quick Chat: " }, function(input)
              if input ~= "" then
                chat.reset()
                chat.ask(input, { selection = selection })
              end
            end)
          end,
          desc = "[Q]uick ask",
          mode = "v",
        },
        {
          "<leader>aa",
          function()
            require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions({ selection = selection }))
          end,
          desc = "[A]ctions",
          mode = { "n", "v" },
        },
      }
    end,
    opts = {
      model = "claude-3.5-sonnet",
      auto_insert_mode = true,
      highlight_headers = false,
      window = {
        width = 0.3,
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      chat.setup(opts)

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.keymap.set("n", "<C-r>", chat.reset, { buffer = true, remap = true, desc = "Reset chat" })
          vim.keymap.set("n", "<Esc>", chat.close, { buffer = true, remap = true, desc = "Close the chat window" })
        end,
      })
    end,
  },
}
