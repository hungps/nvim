return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    keys = {
      { "<leader>F", desc = "[F]lutter" },
      { "<leader>Fd", "<Cmd>FlutterDevices<CR>", desc = "Select [D]evices" },
      { "<leader>Fr", "<Cmd>FlutterRestart<CR>", desc = "Hot [R]estart" },
      { "<leader>Fo", "<Cmd>FlutterOutlineToggle<CR>", desc = "Toggle [O]utline" },
    },
    opts = {
      decorations = {
        statusline = {
          device = true,
          project_config = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
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
        autostart = true,
        auto_open_browser = true,
      },
      lsp = {
        color = {
          enabled = true,
        },
      },
    },
  },

  -- -- add flutter extension to telescope
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      require("telescope").load_extension "flutter"
    end,
  },

  -- add dart to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "dart" })
    end,
  },

  -- hide generated files in neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
      opts.filesystem.filtered_items.hide_by_pattern = opts.filesystem.filtered_items.hide_by_pattern or {}

      vim.list_extend(opts.filesystem.filtered_items.hide_by_pattern, {
        "**/*.g.dart",
        "**/*.gr.dart",
        "**/*.gen.dart",
        "**/*.freezed.dart",
        "**/*.config.dart",
      })
    end,
  },

  -- hide flutter dev log from the bufferline (tab)
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        custom_filter = function(buf_number, _)
          if vim.fn.bufname(buf_number) ~= "__FLUTTER_DEV_LOG__" then
            return true
          end
        end,
      },
    },
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
      local luasnip = require "luasnip"

      luasnip.filetype_extend("dart", { "flutter" })
    end,
  },

  -- tasks
  {
    "stevearc/overseer.nvim",
    optional = true,
    opts = {},
    keys = {
      { "<leader>Fb", desc = "[F]lutter [b]uild_runner" },
      { "<leader>Fbr", "<Cmd>OverseerRun build_runner:run<CR>", desc = "Flutter build_runner build" },
      { "<leader>Fbw", "<Cmd>OverseerRun build_runner:watch<CR>", desc = "Flutter build_runner watch" },
    },
    init = function()
      local overseer = require "overseer"

      overseer.register_template {
        name = "build_runner:run",
        condition = {
          filetype = { "dart" },
        },
        builder = function()
          return {
            cmd = {
              "fvm",
              "flutter",
              "pub",
              "run",
              "build_runner",
              "build",
            },
            components = {
              "default",
            },
          }
        end,
      }

      overseer.register_template {
        name = "build_runner:watch",
        condition = {
          filetype = { "dart" },
        },
        builder = function()
          return {
            cmd = {
              "fvm",
              "flutter",
              "pub",
              "run",
              "build_runner",
              "watch",
              "--delete-conflicting-outputs",
            },
            components = {
              "on_result_notify",
              "default",
            },
          }
        end,
      }
    end,
  },
}
