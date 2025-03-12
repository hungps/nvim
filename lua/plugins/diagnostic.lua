-- Custom diagnostics icon in signcolumn
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Only show the highest severity diagnostic sign
-- See `:help diagnostic-handlers-example`
local ns = vim.api.nvim_create_namespace("diagnostic-signs-priority")
local orig_signs_handler = vim.diagnostic.handlers.signs
vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, _, show_opts)
    local diagnostics = vim.diagnostic.get(bufnr)
    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
      local m = max_severity_per_line[d.lnum]
      if not m or d.severity < m.severity then
        max_severity_per_line[d.lnum] = d
      end
    end
    local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, show_opts)
  end,
  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}

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
