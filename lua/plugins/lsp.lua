return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "jsonlint",
        "markdownlint",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-tool-installer").setup { ensure_installed = opts.ensure_installed }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "j-hui/fidget.nvim", opts = {} },
      { "folke/neodev.nvim", opts = {} },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                  [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
            },
          },
        },
      },
      capabilities = {
        -- textDocument = {
        --   completion = {
        --     completionItem = {
        --       documentationFormat = { "markdown", "plaintext" },
        --       snippetSupport = true,
        --       preselectSupport = true,
        --       insertReplaceSupport = true,
        --       labelDetailsSupport = true,
        --       deprecatedSupport = true,
        --       commitCharactersSupport = true,
        --       tagSupport = { valueSet = { 1 } },
        --       resolveSupport = {
        --         properties = {
        --           "documentation",
        --           "detail",
        --           "additionalTextEdits",
        --         },
        --       },
        --     },
        --   },
        -- },
      },
    },
    config = function(_, opts)
      -- Inject lsp keymap, highlight.. when attaching Lsp
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Mapping lsp action when attached",
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if not client then
            return
          end

          -- Mapping lsp action when attached
          local map = function(modes, keys, func, desc)
            vim.keymap.set(modes, keys, func, { buffer = event.buf, desc = desc })
          end
          map("n", "gd", vim.lsp.buf.definition, "[G]oto: [D]efinition")
          map("n", "gD", vim.lsp.buf.declaration, "[G]oto: [D]eclaration")
          map("n", "gi", vim.lsp.buf.implementation, "[G]oto: [I]mplementation")
          map("n", "gr", vim.lsp.buf.references, "[G]oto: References")
          map("n", "K", vim.lsp.buf.hover, "Show documentation")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Toggle signature")
          map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "[A]dd Workspace")
          map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "[R]emove Workspace")
          map("n", "<leader>cd", vim.lsp.buf.type_definition, "Type [D]efinition")
          map("n", "<leader>cr", vim.lsp.buf.rename, "[R]ename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")

          -- Enable inlay hints if the language server supports
          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.toggle = function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = nil })
            end
            map("n", "<leader>ch", vim.lsp.inlay_hint.toggle, "Toggle Inlay [H]ints")
          end

          -- Highlight references of the word under your cursor when your cursor rests there for a little while.
          if client.server_capabilities.documentHighlightProvider then
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
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
              end,
            })
          end
        end,
      })

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local servers = opts.servers or {}

      local setup = function(server_name)
        local server = servers[server_name]
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
      require("mason-lspconfig").setup {
        ensure_installed = ensure_installed,
        handlers = { setup },
      }
    end,
  },
}
