return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {},
      capabilities = {},
    },
    config = function(_, opts)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      for _, extra_capabilities in pairs(opts.capabilities) do
        capabilities = vim.tbl_deep_extend("force", capabilities, extra_capabilities)
      end

      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
      })

      for server in pairs(opts.servers) do
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then return end

          local map = function(modes, keys, func, desc)
            vim.keymap.set(modes, keys, func, { buffer = event.buf, desc = desc, noremap = true })
          end
          map("n", "grd", vim.lsp.buf.definition, "Goto Definition")
          map("n", "grD", vim.lsp.buf.declaration, "Goto Declaration")
          map("n", "gri", vim.lsp.buf.implementation, "Goto Implementation")
          map("n", "grr", vim.lsp.buf.references, "Goto References")
          map("n", "grt", vim.lsp.buf.type_definition, "Goto Type Definition")
          map("n", "grs", vim.lsp.buf.signature_help, "Show Signature")
          map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "gra", vim.lsp.buf.code_action, "Code Action")

          -- Inlay hints
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            local toggle_inlay_hint = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end
            map("n", "<leader>ti", toggle_inlay_hint, "[I]nlay [H]ints")
          end

          -- Highlight references of the word under your cursor
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-highlight-detach", { clear = true }),
              callback = function(detach_event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = detach_event.buf })
              end,
            })
          end

          -- Set folding method to lsp.foldexpr
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange, event.buf) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldmethod = "expr"
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-folding-detach", { clear = true }),
              command = "setl foldexpr<",
            })
          end
        end,
      })
    end,
  },
}
