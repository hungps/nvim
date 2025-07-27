return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dap-view").toggle() end, desc = "Dap View" },
          { "<leader>de", function() require("dap-view").add_expr() end, desc = "Eval", mode = { "n", "v" } },
        },
        opts = {
          winbar = {
            show = true,
            sections = { "repl", "watches", "exceptions", "breakpoints", "threads" },
            default_section = "repl",
          },
          windows = {
            terminal = {
              hide = { "dart" },
            },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>di", function() require("dap.ui.widgets").hover() end, desc = "Inspect value under cursor" },
      { "<leader>dI", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes()) end, desc = "Inspect values in scope" },
      { "<leader>da", desc = "+Actions" },
      { "<leader>dap", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dat", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dac", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>daC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dal", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>dai", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>daj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dak", function() require("dap").up() end, desc = "Up" },
      { "<leader>dal", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dao", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>daO", function() require("dap").step_over() end, desc = "Step Over" },
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "ErrorMsg" })

      local dap, dv = require("dap"), require("dap-view")

      dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
      dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
      -- dap.listeners.before.event_terminated["dap-view-config"] = function()
      --   dv.close()
      -- end
      dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end
    end,
  },
}
