local codecompanion = require("codecompanion")

codecompanion.setup()

map({ "n", "v" }, "<Leader>ac", "<Cmd>CodeCompanionChat Toggle<CR>", "Chat")
map({ "n", "v" }, "<Leader>aa", "<Cmd>CodeCompanionActions<CR>", "Actions")
map("v", "<Leader>aq", function() vim.cmd("'<,'>CodeCompanion " .. (vim.fn.input("Ask: ") or "")) end, "Ask")
