return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        opts = {
          windows = { indent = 2 },
          layouts = {
            {
              elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
              },
              position = "left",
              size = 20,
            },
            { elements = { { id = "repl", size = 0.9 } }, position = "bottom", size = 7 },
          },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "williamboman/mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = false,
          handlers = {},
          ensure_installed = {},
        },
      },
      -- -- VsCode launch.json parser
      {
        "folke/neoconf.nvim",
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dapui").toggle(2) end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local dap = require "dap"
      local ui_ok, dapui = pcall(require, "dapui")

      if not ui_ok then
        return
      end

      local debug_win = nil
      local debug_tab = nil
      local debug_tabnr = nil

      local function open_in_tab()
        if debug_win and vim.api.nvim_win_is_valid(debug_win) then
          vim.api.nvim_set_current_win(debug_win)
          return
        end

        vim.cmd "tabedit %"
        debug_win = vim.fn.win_getid()
        debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
        debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

        dapui.open(2)
      end

      local function close_tab()
        dapui.close()

        if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
          vim.api.nvim_exec2("tabclose " .. debug_tabnr, { output = false })
        end

        debug_win = nil
        debug_tab = nil
        debug_tabnr = nil
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        close_tab()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        close_tab()
      end
      dap.listeners.after.event_initialized["dapui_config"] = function()
        open_in_tab()
      end

      -- -- setup dap config by VsCode launch.json file
      -- local vscode = require "dap.ext.vscode"
      -- local _filetypes = require "mason-nvim-dap.mappings.filetypes"
      -- local filetypes = vim.tbl_deep_extend("force", _filetypes, {
      --   ["node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
      --   ["pwa-node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
      -- })
      -- local json = require "plenary.json"
      -- vscode.json_decode = function(str)
      --   return vim.json.decode(json.json_strip_comments(str, {}))
      -- end
      -- vscode.load_launchjs(nil, filetypes)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}

      table.insert(opts.sections.lualine_x, 1, {
        function()
          return "  " .. require("dap").status()
        end,
        cond = function()
          return require("dap").status() ~= ""
        end,
        color = "orange",
      })
    end,
  },
}
