local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = capabilities,
  init_options = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
      refresh = {
        enabled = true,
      },
    },
  },
})

vim.lsp.enable(Config.lsp_servers)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc }) end

    map("n", "grd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "grD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gri", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "grr", vim.lsp.buf.references, "Goto References")
    map("n", "grt", vim.lsp.buf.type_definition, "Goto Type Definition")
    map("n", "grs", vim.lsp.buf.signature_help, "Show Signature")
    map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "gra", vim.lsp.buf.code_action, "Code Action")

    local Methods = vim.lsp.protocol.Methods

    if client:supports_method(Methods.textDocument_inlayHint, ev.buf) then
      map(
        "n",
        "<Leader>ti",
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        "Inlay hints"
      )
    end

    if client:supports_method(Methods.textDocument_foldingRange, ev.buf) then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    if client:supports_method(Methods.textDocument_documentHighlight, ev.buf) then
      local hl_group = vim.api.nvim_create_augroup("LspHighlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = ev.buf,
        group = hl_group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = ev.buf,
        group = hl_group,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
