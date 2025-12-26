vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "ErrorMsg" })

local dap, widgets = require("dap"), require("dap.ui.widgets")

for name, config in pairs(Config.dap) do
  dap.configurations[name] = config
end

for name, adapter in pairs(Config.dap_adapters) do
  dap.adapters[name] = adapter
end

-- stylua: ignore start
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Breakpoint Condition")
map("n", "<leader>db", function() dap.toggle_breakpoint() end, "Toggle Breakpoint")
map("n", "<leader>ds", function() dap.session() end, "Session")
map("n", "<leader>di", function() widgets.hover() end, "Inspect value under cursor")
map("n", "<leader>dI", function() widgets.centered_float(widgets.scopes()) end, "Inspect values in scope")
map("n", "<leader>dap", function() dap.pause() end, "Pause")
map("n", "<leader>dat", function() dap.terminate() end, "Terminate")
map("n", "<leader>dac", function() dap.continue() end, "Continue")
map("n", "<leader>daC", function() dap.run_to_cursor() end, "Run to Cursor")
map("n", "<leader>dal", function() dap.goto_() end, "Go to Line (No Execute)")
map("n", "<leader>dai", function() dap.step_into() end, "Step Into")
map("n", "<leader>daj", function() dap.down() end, "Down")
map("n", "<leader>dak", function() dap.up() end, "Up")
map("n", "<leader>dal", function() dap.run_last() end, "Run Last")
map("n", "<leader>dao", function() dap.step_out() end, "Step Out")
map("n", "<leader>daO", function() dap.step_over() end, "Step Over")
-- stylua: ignore end

local dap_view = require("dap-view")

dap_view.setup({
  winbar = {
    show = true,
    sections = { "repl", "watches", "scopes", "exceptions", "breakpoints", "threads" },
    default_section = "repl",
    controls = {
      enabled = true,
      position = "left",
    },
  },
  windows = {
    terminal = {
      hide = { "dart" },
    },
  },
})

dap.listeners.before.attach["dap-view-config"] = function() dap_view.open() end
dap.listeners.before.launch["dap-view-config"] = function() dap_view.open() end
dap.listeners.before.event_exited["dap-view-config"] = function() dap_view.close() end
-- dap.listeners.before.event_terminated["dap-view-config"] = function() dap_view.close() end

map("n", "<leader>du", function() require("dap-view").toggle() end, "Dap View")
map({ "n", "v" }, "<leader>de", function() require("dap-view").add_expr() end, "Eval")
