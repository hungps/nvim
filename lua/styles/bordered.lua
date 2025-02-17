local border_type = "single"

return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function()
      vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border_type,
      })
      vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_signatureHelp] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
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
        completion = { border = border_type },
        documentation = { border = border_type },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    opts = function(_, opts)
      opts.winopts.border = border_type
      opts.winopts.preview.border = border_type
    end,
  },
}
