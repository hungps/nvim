return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.spec, {
        { "<leader>F", group = "Flutter" },
        { "<leader>Fb", group = "build_runner" },
      })
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    cmd = { "FlutterDevices", "FlutterEmulators" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>Fd", "<Cmd>FlutterDevices<CR>", desc = "Select Devices" },
      { "<leader>Fr", "<Cmd>FlutterRestart<CR>", desc = "Hot Restart" },
      { "<leader>Fo", "<Cmd>FlutterOutlineToggle<CR>", desc = "Toggle Outline" },
    },
    opts = {
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
          analysisExcludedFolders = {
            vim.uv.cwd() .. "/.git",
            vim.uv.cwd() .. "/.fvm",
            vim.uv.cwd() .. "/.dart_tool",
            vim.uv.cwd() .. "/build",
            vim.uv.cwd() .. "/android",
            vim.uv.cwd() .. "/ios",
            vim.uv.cwd() .. "/assets",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "dart", "yaml" }) end,
  },
  {
    "echasnovski/mini.files",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.content.hidden_file_suffix, {
        ".g.dart",
        ".gr.dart",
        ".gen.dart",
        ".freezed.dart",
        ".config.dart",
        ".flutter-plugins",
        ".flutter-plugins-dependencies",
        ".dart_tool",
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "sidlatau/neotest-dart" },
    opts = {
      adapters = {
        ["neotest-dart"] = {
          command = "fvm flutter",
          custom_test_method_names = { "testWidgetsWithDeps", "testWithDeps" },
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    opts = function() require("luasnip").filetype_extend("dart", { "flutter" }) end,
  },
  {
    "igorlfs/nvim-dap-view",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.windows.terminal.hide, {
        "dart",
        "flutter",
      })
    end,
  },
}
