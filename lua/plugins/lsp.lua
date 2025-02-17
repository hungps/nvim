return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
      },
    },
    opts = {
      servers = {},
      capabilities = {},
    },
    config = function(_, opts)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      for _, value in ipairs(opts.capabilities) do
        capabilities = vim.tbl_deep_extend("force", capabilities, value)
      end

      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      local servers = opts.servers or {}

      local setup = function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", capabilities, server.capabilities or {})
        require("lspconfig")[server_name].setup(server)
      end

      -- Filtering out the servers that are not exist in mason and install them manually
      local all_masonlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      local ensure_installed = {}
      for server in pairs(servers) do
        if not vim.tbl_contains(all_masonlsp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      -- setup mason lsp servers
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = { setup },
      })

      -- Inject lsp keymap, highlight.. when attaching Lsp
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Mapping lsp actions when attached",
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if not client then
            return
          end

          local map = function(modes, keys, func, desc)
            vim.keymap.set(modes, keys, func, { buffer = event.buf, desc = desc })
          end
          map("n", "K", vim.lsp.buf.hover, "Show documentation")
          map("n", "gd", vim.lsp.buf.definition, "[G]oto: [D]efinition")
          map("n", "gD", vim.lsp.buf.declaration, "[G]oto: [D]eclaration")
          map("n", "gi", vim.lsp.buf.implementation, "[G]oto: [I]mplementation")
          map("n", "gr", vim.lsp.buf.references, "[G]oto: References")
          map("n", "go", vim.lsp.buf.type_definition, "Type [D]efinition")
          map("n", "gs", vim.lsp.buf.signature_help, "Show [S]ignature")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")
          map("n", "<leader>cr", function()
            vim.lsp.buf.rename()
            vim.cmd("wa")
          end, "[R]ename symbol")

          -- Enable inlay hints if the language server supports
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            local toggle_inlay_hint = function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end
            map("n", "<leader>ti", toggle_inlay_hint, "[I]nlay [H]ints")
          end

          -- Highlight references of the word under your cursor when your cursor rests there for a little while.
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(detach_event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = detach_event.buf })
              end,
            })
          end

          -- Show diagnostic popup on hover
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = event.buf,
            group = vim.api.nvim_create_augroup("lsp-float-diagnostic", { clear = false }),
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
        end,
      })
    end,
  },
}
