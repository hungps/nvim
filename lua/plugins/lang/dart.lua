return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    cmd = { "FlutterDevices" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>F", desc = "[F]lutter" },
      { "<leader>Fd", "<Cmd>FlutterDevices<CR>", desc = "Select [D]evices" },
      { "<leader>Fr", "<Cmd>FlutterRestart<CR>", desc = "Hot [R]estart" },
      { "<leader>Fo", "<Cmd>FlutterOutlineToggle<CR>", desc = "Toggle [O]utline" },
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
        settings = {
          analysisExcludedFolders = {
            "~/fvm/",
            "~/.pub-cache/",
            vim.uv.cwd() .. ".fvm/",
            vim.uv.cwd() .. ".dart_tool",
            vim.uv.cwd() .. "build",
            vim.uv.cwd() .. "android",
            vim.uv.cwd() .. "ios",
            vim.uv.cwd() .. "assets",
          },
        },
      },
    },
  },
  -- add dart to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "dart" })

      -- FIXME: https://github.com/UserNobody14/tree-sitter-dart/issues/60#issuecomment-1867049690
      vim.list_extend(opts.indent.disable, { "dart" })

      -- FIXME: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/627
      vim.list_extend(opts.textobjects.select.disable, { "dart" })
    end,
  },

  -- hide generated files in mini.files
  {
    "echasnovski/mini.files",
    optional = true,
    opts = function(_, opts)
      opts.content.hidden_file_suffix = opts.content.hidden_file_suffix or {}

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

  -- neo-test support
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "sidlatau/neotest-dart",
    },
    opts = {
      adapters = {
        ["neotest-dart"] = {
          command = "fvm flutter",
          custom_test_method_names = { "testWidgetsWithDeps", "testWithDeps" },
        },
      },
    },
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    opts = function()
      require("luasnip").filetype_extend("dart", { "flutter" })
    end,
  },
}
