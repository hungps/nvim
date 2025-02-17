return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function()
      require("which-key").add({
        { "<leader>gd", desc = "[D]iff" },
        { "<leader>gh", desc = "[H]unk" },
        { "<leader>gt", desc = "[T]oggle" },
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      {
        "<leader>gg",
        "<Cmd>tab Git<CR>",
        desc = "[G]it",
      },
      {
        "<leader>gl",
        "<Cmd>Git log<CR>",
        desc = "Git [L]og",
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
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next [H]unk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous [H]unk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last [H]unk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First [H]unk")

        map("n", "<leader>gp", gs.preview_hunk, "[P]review hunk")
        map("n", "<leader>gb", gs.blame_line, "[B]lame line")

        map('n', '<leader>ghs', gs.stage_hunk, "[S]tage hunk")
        map('n', '<leader>ghS', gs.stage_buffer, "[S]tage buffer")
        map('n', '<leader>ghr', gs.reset_hunk, "[R]eset hunk")
        map('n', '<leader>ghR', gs.reset_buffer, "[R]eset buffer")
        map('n', '<leader>ghu', gs.undo_stage_hunk, "[U]ndo stage hunk")
        map('n', '<leader>gtd', gs.toggle_deleted, "Toggle [D]eleted")
        map('n', '<leader>gtb', gs.toggle_current_line_blame, "Toggle [B]lame")
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gda", "<Cmd>DiffviewFileHistory<CR>", desc = "[A]ll History" },
      { "<leader>gdf", "<Cmd>DiffviewFileHistory --follow %<CR>", desc = "[F]ile history" },
      { "<leader>gdl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "[L]ine history" },
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
