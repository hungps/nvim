local function alpha_setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", "<cmd>ene <CR>"),
    dashboard.button("SPC f e", "  File explorer"),
    dashboard.button("SPC f f", "󰱼  Find file"),
    dashboard.button("SPC f g", "󰺮  Find by grep"),
    dashboard.button("SPC g g", "  Git explorer"),
    dashboard.button("SPC g s", "  Git status"),
    dashboard.button("SPC x x", "  Diagnostics"),
    dashboard.button("SPC q q", "  Quit"),
  }

  alpha.setup(dashboard.opts)
end

return {
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("AlphaInit", { clear = true }),
        callback = function()
          local f = vim.fn.expand("%:p")
          if vim.fn.isdirectory(f) ~= 0 then
            alpha_setup()
            vim.cmd([[Alpha]])
            vim.api.nvim_clear_autocmds({ group = "AlphaInit" })
          end
        end,
      })
    end,
    config = function()
      alpha_setup()
    end,
  },
}
