add({
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "shumphrey/fugitive-gitlab.vim",
}, function()
  map("n", "<Leader>gg", "<Cmd>tab Git<CR>", "Git")
  map("n", "<Leader>gl", "<Cmd>Git log<CR>", "Git log")
end)

add({ source = "lewis6991/gitsigns.nvim", checkout = "v1.0.2" }, function()
  local gs = require("gitsigns")

  gs.setup({
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
    word_diff = false,
    preview_config = {
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    sign_priority = 100,
    on_attach = function(buffer)
      local opts = { buffer = buffer }

      map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk", opts)
      map("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk", opts)
      map("n", "]H", function() gs.nav_hunk("last") end, "Last hunk", opts)
      map("n", "[H", function() gs.nav_hunk("first") end, "First hunk", opts)

      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line", opts)
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle blame", opts)

      map("n", "<leader>gd", function() gs.diffthis() end, "Diff with index", opts)
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff with ~", opts)

      map("n", "<leader>gp", gs.preview_hunk, "Preview hunk", opts)
      map("n", "<leader>gP", gs.preview_hunk_inline, "Inline preview hunk", opts)

      map("n", "<leader>gr", gs.reset_hunk, "Reset hunk", opts)
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk", opts)
      map("n", "<leader>gR", gs.reset_buffer, "Reset buffer", opts)

      map("n", "<leader>gs", gs.stage_hunk, "Stage hunk", opts)
      map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk", opts)
      map("n", "<leader>gS", gs.stage_buffer, "Stage buffer", opts)

      map("n", "<leader>gq", function() gs.setqflist("attached") end, "Send buffer hunks to qflist", opts)
      map("n", "<leader>gQ", function() gs.setqflist("all") end, "Send all hunks to qflist", opts)

      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk", opts)
    end,
  })
end)
