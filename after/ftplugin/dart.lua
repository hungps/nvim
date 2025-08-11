require("flutter-tools").setup({
  debugger = {
    enabled = true,
    run_via_dap = true,
    exception_breakpoints = {},
    register_configurations = function()
      require("dap").configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  fvm = true,
  widget_guides = {
    enabled = true,
  },
  dev_log = {
    enabled = false,
    notify_errors = true,
    open_cmd = "10split",
  },
  dev_tools = {
    autostart = false,
    auto_open_browser = false,
  },
  lsp = {
    color = {
      enabled = true,
      background = true,
      virtual_text = false,
    },
    capabilities = {
      [vim.lsp.protocol.Methods.workspace_willRenameFiles] = true,
      [vim.lsp.protocol.Methods.workspace_didRenameFiles] = true,
    },
    settings = {
      showTodos = false,
      completeFunctionCalls = false,
      lineLength = require("hungps.utils.dart").get_line_length(),
    },
  },
})

map("n", "<Leader>F", "<nop>", "+Flutter")
map("n", "<Leader>Fd", "<Cmd>FlutterDevices<CR>", "Select devices")
map("n", "<Leader>Fr", "<Cmd>FlutterRestart<CR>", "Hot restart")
map("n", "<Leader>Fo", "<Cmd>FlutterOutlineToggle<CR>", "Toggle outline")
