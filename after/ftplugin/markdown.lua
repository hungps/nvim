vim.opt_local.wrap = true

local markdown = require("render-markdown")

markdown.setup({
  -- file_types = { "markdown", "codecompanion" },
  render_modes = true,
  completions = { lsp = { enabled = true } },
  sign = { enabled = false },
  quote = { repeat_linebreak = true },
  win_options = {
    showbreak = { default = "", rendered = "  " },
    breakindent = { default = false, rendered = true },
    breakindentopt = { default = "", rendered = "" },
  },
  heading = {
    position = "inline",
    custom = {},
  },
  bullet = {
    enabled = false,
  },
  checkbox = {
    enabled = false,
  },
})
