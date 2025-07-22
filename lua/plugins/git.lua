return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function()
      require("which-key").add({
        { "<leader>gd", desc = "Diff" },
        { "<leader>gh", desc = "Hunk" },
        { "<leader>gt", desc = "Toggle" },
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
      "shumphrey/fugitive-gitlab.vim",
    },
    lazy = false,
    keys = {
      {
        "<leader>gg",
        "<Cmd>tab Git<CR>",
        desc = "Git",
      },
      {
        "<leader>gl",
        "<Cmd>Git log<CR>",
        desc = "Git Log",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")

        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First hunk")

        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gP", gs.preview_hunk_inline, "Inline Preview hunk")
        map("n", "<leader>gb", gs.blame_line, "Blame line")

        map('n', '<leader>ghs', gs.stage_hunk, "Stage hunk")
        map('n', '<leader>ghS', gs.stage_buffer, "Stage buffer")
        map('n', '<leader>ghr', gs.reset_hunk, "Reset hunk")
        map('n', '<leader>ghR', gs.reset_buffer, "Reset buffer")
        map('n', '<leader>ghu', gs.undo_stage_hunk, "Undo stage hunk")

        map('n', '<leader>ghq', function() gs.setqflist({ target = "attached" }) end, "Send buffer hunks to qflist")
        map('n', '<leader>ghQ', function() gs.setqflist({ target = "all" }) end, "Send all hunks to qflist")

        map('n', '<leader>gtd', gs.toggle_deleted, "Toggle deleted")
        map('n', '<leader>gtb', gs.toggle_current_line_blame, "Toggle blame")

        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        map({'o', 'x'}, 'ah', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gda", "<Cmd>DiffviewFileHistory<CR>", desc = "All History" },
      { "<leader>gdf", "<Cmd>DiffviewFileHistory --follow %<CR>", desc = "File history" },
      { "<leader>gdl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "Line history" },
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
}
