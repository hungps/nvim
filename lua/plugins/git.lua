return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function()
      require("which-key").add({
        { "<leader>gh", desc = "[H]istory" },
      })
    end,
  },
  {
    "echasnovski/mini-git",
    event = "VeryLazy",
    main = "mini.git",
    opts = {},
  },
  {
    "echasnovski/mini.diff",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>gp",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "[P]review hunks",
      },
    },
    opts = {
      view = {
        priority = 0,
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gs", "<Cmd>DiffviewOpen<CR>", desc = "[S]tatus" },
      { "<leader>gha", "<Cmd>DiffviewFileHistory<CR>", desc = "[A]ll History" },
      { "<leader>ghf", "<Cmd>DiffviewFileHistory --follow %<CR>", desc = "[F]ile history" },
      { "<leader>ghl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "[L]ine history" },
      { "<leader>ghr", "<Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = { "v" }, desc = "[R]ange history" },
    },
    opts = {
      keymaps = {
        view = {
          { "n", "<esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
          { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
        },
        file_panel = {
          { "n", "<esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
          { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
        },
        file_history_panel = {
          { "n", "<esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
          { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
        },
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazy[G]it" },
    },
  },
}
