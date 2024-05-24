return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Diagnostics in [D]ocument" },
      { "<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Diagnostics in [W]orkspace" },
      { "<leader>dL", "<cmd>TroubleToggle loclist<cr>", desc = "[L]ocation List" },
      { "<leader>dq", "<cmd>TroubleToggle quickfix<cr>", desc = "[Q]uickfix List" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
}
