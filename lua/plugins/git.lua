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
        local wk = require "which-key"

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        -- Navigation
        map("n", "]h", function() gs.nav_hunk("next") end, "Next [H]unk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous [H]unk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last [H]unk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First [H]unk")

        -- Actions
        -- wk.register({ ["<leader>gh"] = "[G]it: [H]unk" }, { mode = "v" })
        -- map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[S]tage selected hunk")
        -- map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[R]eset selected hunk")

        wk.register({ ["<leader>gh"] = "[H]unk" })
        -- map("n", "<leader>ghs", gs.stage_hunk, "[S]tage hunk")
        -- map("n", "<leader>ghr", gs.reset_hunk, "[R]eset hunk")
        -- map("n", "<leader>ghu", gs.undo_stage_hunk, "[U]ndo hunk")
        map("n", "<leader>ghp", gs.preview_hunk, "[P]review hunk")

        -- wk.register({ ["<leader>ghb"] = "[G]it [H]unk [B]uffer" })
        -- map("n", "<leader>ghbs", gs.stage_buffer, "[S]tage buffer hunk")
        -- map("n", "<leader>ghbr", gs.reset_buffer, "[R]eset buffer hunk")

        map("n", "<leader>gb", gs.blame_line, "[B]lame line")
        map("n", "<leader>ghd", gs.diffthis, "[D]iff against index")
        map("n", "<leader>ghD", function() gs.diffthis("@") end, "[D]iff against last commit")

        -- Toggles
        -- wk.register({ ["<leader>gt"] = "[G]it [T]oggle" })
        -- map("n", "<leader>gtb", gs.toggle_current_line_blame, "[T]oggle [B]lame line")
        -- map("n", "<leader>gtd", gs.toggle_deleted, "[T]oggle [D]eleted")
      end,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>gg",
        function()
          require("utils.lazygit").open()
        end,
        desc = "[G]it Explorer",
      },
    },
  },
}
