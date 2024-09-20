local border_type = "rounded"

return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border_type,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
        border = border_type,
      })
      vim.diagnostic.config({
        float = { border = border_type },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
        completion = require("cmp").config.window.bordered({
          winhighlight = "Normal:NormalFloat,CursorLine:PmenuSel",
        }),
        documentation = require("cmp").config.window.bordered({
          winhighlight = "Normal:NormalFloat,CursorLine:PmenuSel",
        }),
      })
    end,
  },
  {
    "echasnovski/mini.pick",
    optional = true,
    opts = function(_, opts)
      opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
        config = { border = border_type },
      })
    end,
  },
  {
    "echasnovski/mini.files",
    optional = true,
    opts = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
          local config = vim.api.nvim_win_get_config(args.data.win_id)

          -- border
          config.border = border_type

          -- title padding
          table.insert(config.title, { " ", "MiniFilesTitle" })
          table.insert(config.title, 1, { " ", "MiniFilesTitle" })

          vim.api.nvim_win_set_config(args.data.win_id, config)
        end,
      })
    end,
  },
}
