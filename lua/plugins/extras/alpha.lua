local function alpha_setup()
  local alpha = require "alpha"
  local dashboard = require "alpha.themes.dashboard"

  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", "<cmd>ene <CR>"),
    dashboard.button("SPC f f", "󰈞  Find file"),
    dashboard.button("SPC f h", "󰊄  Recently opened files"),
    dashboard.button("SPC s s", "󰈬  Find word"),
    dashboard.button("SPC w o", "󰈬  Open workspace"),
    -- dashboard.button("SPC f m", "  Jump to bookmarks"),
    -- dashboard.button("SPC s l", "  Open last session"),
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
          local f = vim.fn.expand "%:p"
          if vim.fn.isdirectory(f) ~= 0 then
            alpha_setup()
            vim.cmd [[Alpha]]
            vim.api.nvim_clear_autocmds { group = "AlphaInit" }
          end
        end,
      })
    end,
    config = function()
      alpha_setup()
      vim.schedule(function()
        vim.cmd [[Neotree show]]
      end)
    end,
  },
}
