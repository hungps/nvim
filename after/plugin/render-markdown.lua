local markdown = require("render-markdown")

markdown.setup({
  -- file_types = { "markdown", "codecompanion" },
  render_modes = true,
  heading = { position = "inline" },
  completions = { blink = { enabled = true } },
})
