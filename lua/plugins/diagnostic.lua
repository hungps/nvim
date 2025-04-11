vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  -- virtual_lines = {
  --   current_line = true,
  -- },
  float = {
    severity_sort = true,
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

-- Show diagnostic popup on hover
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("custom-float-diagnostic", { clear = false }),
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      source = true,
      scope = "line",
      severity_sort = true,
    })
  end,
})

return {
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    cmd = "Trouble",
    -- stylua: ignore
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
    opts = {
      auto_close = true,
      use_diagnostic_signs = true,
    },
  },
}
