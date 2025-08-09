local substitute = require("substitute")
local range = require("substitute.range")
local exchange = require("substitute.exchange")

substitute.setup({
  range = {
    confirm = true,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    if ev.match == "fugitive" then return end

    map("n", "s", substitute.operator, "Substitute", { buffer = ev.buf })
    map("n", "ss", substitute.line, "Substitute line", { buffer = ev.buf })
    map("n", "S", substitute.eol, "Substitute to end of line", { buffer = ev.buf })
    map("x", "s", substitute.visual, "Substitute", { buffer = ev.buf })

    map("n", "sr", range.operator, "Substitute range", { buffer = ev.buf })
    map("n", "srs", range.word, "Substitute word", { buffer = ev.buf })
    map("x", "sr", range.visual, "Substitute", { buffer = ev.buf })

    map("n", "sx", exchange.operator, "Exchange", { buffer = ev.buf })
    map("n", "sxx", exchange.line, "Exchange line", { buffer = ev.buf })
    map("n", "sxc", exchange.cancel, "Cancel exchange", { buffer = ev.buf })
    map("x", "X", exchange.visual, "Exchange", { buffer = ev.buf })
  end,
})
