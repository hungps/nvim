-- local dart_utils = require("hungps.utils.dart")

_G.Config = {
  lsp_servers = {},
  linters_by_ft = {},
  formatters_by_ft = {
    json = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
  debuggers_by_ft = {},
  dap = {},
  dap_adapters = {},
  treesitter_parsers = {
    "vim",
    "vimdoc",
    "http",
    "json",
    "bash",
    "cmake",
    "dockerfile",
    "editorconfig",
  },
  hidden_file_patterns = {
    "^%.git$",
    "^%.DS_Store$",
  },
}

local config_by_ft = {
  lua = {
    lsp_servers = { "lua_ls" },
    treesitter_parsers = { "lua", "luadoc" },
    formatters = { "stylua" },
  },
  dart = {
    -- debuggers = { "dart-debug-adapter" },
    -- lsp_servers = { "dartls" },
    -- dap = {
    --   dart = {
    --     {
    --       type = "dart",
    --       request = "launch",
    --       name = "Launch dart",
    --       dartSdkPath = dart_utils.dart_path(),
    --       flutterSdkPath = dart_utils.flutter_path(),
    --       program = "${workspaceFolder}/lib/main.dart",
    --       cwd = "${workspaceFolder}",
    --     },
    --     {
    --       type = "flutter",
    --       request = "launch",
    --       name = "Launch flutter",
    --       dartSdkPath = dart_utils.dart_path(),
    --       flutterSdkPath = dart_utils.flutter_path(),
    --       program = "${workspaceFolder}/lib/main.dart",
    --       cwd = "${workspaceFolder}",
    --     },
    --   },
    -- },
    -- dap_adapters = {
    --   dart = {
    --     type = "executable",
    --     command = dart_utils.dart_path(),
    --     args = { "debug_adapter" },
    --     options = {
    --       detached = false,
    --     },
    --   },
    --   flutter = {
    --     type = "executable",
    --     command = dart_utils.flutter_path(),
    --     args = { "debug_adapter" },
    --     options = {
    --       detached = false,
    --     },
    --   },
    -- },
    treesitter_parsers = { "dart", "yaml" },
    hidden_file_patterns = {
      ".%.g%.dart$",
      ".%.gr%.dart$",
      ".%.gen%.dart$",
      ".%.freezed%.dart$",
      ".%.config%.dart$",
      "^%.flutter-plugins$",
      "^%.flutter-plugins-dependencies$",
      "^%.dart_tool$",
    },
  },
  swift = {
    lsp_servers = { "sourcekit" },
  },
  markdown = {},
  ruby = {
    lsp_servers = { "ruby_lsp" },
    treesitter_parsers = { "ruby" },
  },
  rust = {
    lsp_servers = { "rust_analyzer" },
  },
  fennel = {
    lsp_servers = { "fennel_ls" },
    treesitter_parsers = { "fennel" },
  },
  yaml = {
    lsp_servers = { "yamlls" },
    treesitter_parsers = { "yaml" },
  },
}

for ft, config in pairs(config_by_ft) do
  _G.Config.formatters_by_ft[ft] = config.formatters or {}
  _G.Config.linters_by_ft[ft] = config.linters or {}
  _G.Config.debuggers_by_ft[ft] = config.debuggers or {}

  _G.Config.dap = vim.tbl_extend("error", _G.Config.dap, config.dap or {})
  _G.Config.dap_adapters = vim.tbl_extend("error", _G.Config.dap_adapters, config.dap_adapters or {})

  vim.list_extend(_G.Config.lsp_servers, config.lsp_servers or {})
  vim.list_extend(_G.Config.hidden_file_patterns, config.hidden_file_patterns or {})
  vim.list_extend(_G.Config.treesitter_parsers, config.treesitter_parsers or {})
end
