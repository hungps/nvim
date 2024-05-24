return {
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
    config = function(_, opts)
      local navic = require "nvim-navic"

      navic.setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Attach navic to lsp",
        group = vim.api.nvim_create_augroup("navic-lsp-attach", {}),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, event.buf)
          end
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      opts.winbar = opts.winbar or {}
      opts.winbar.lualine_c = opts.winbar.lualine_c or {}

      table.insert(opts.winbar.lualine_c, {
        function()
          return require("nvim-navic").get_location()
        end,
        cond = function()
          return require("nvim-navic").is_available()
        end,
      })
    end,
  },
}
