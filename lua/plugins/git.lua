return {
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
      on_attach = function(buffer)
        local gs = require "gitsigns"

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
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gs", "<Cmd>DiffviewOpen<CR>", desc = "Current [S]tatus" },
      { "<leader>gh", desc = "[G]it [H]istory" },
      { "<leader>gha", "<Cmd>DiffviewFileHistory<CR>", desc = "[A]ll History" },
      { "<leader>ghf", "<Cmd>DiffviewFileHistory --follow %<CR>", desc = "[F]ile history" },
      { "<leader>ghl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "[L]ine history" },
      { "<leader>ghr", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = { "v" }, desc = "[R]ange history" },
    },
    opts = {},
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazy[G]it" },
    },
  },
  -- -- add lazygit extension to telescope
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      require("telescope").load_extension "lazygit"
    end,
  },
}
