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
    settings = {
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("$HOME/fvm"),
        ".dart_tool",
      },
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
map("n", "<Leader>Ft", "<Cmd>FlutterOpenDevTools<CR>", "Open DevTools")
map("n", "<Leader>Fc", "<Cmd>FlutterCopyProfilerUrl<CR>", "Copy profiler url")
map("n", "<Leader>Fq", "<Cmd>FlutterQuit<CR>", "End session")
