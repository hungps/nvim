return {
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
      { "<leader>gs", "<Cmd>DiffviewOpen<CR>", desc = "Current [S]tatus" },
      { "<leader>gh", desc = "[G]it [H]istory" },
      { "<leader>gha", "<Cmd>DiffviewFileHiiostory<CR>", desc = "[A]ll History" },
      { "<leader>ghf", "<Cmd>DiffviewFileHistory --follow %<CR>", desc = "[F]ile history" },
      { "<leader>ghl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "[L]ine history" },
      { "<leader>ghr", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = { "v" }, desc = "[R]ange history" },
      { "<leader>ghq", "<Esc><Cmd>DiffviewClose<CR>", desc = "[C]lose Diffview History" },
    },
    opts = {},
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
