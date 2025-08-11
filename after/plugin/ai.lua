local copilot = require("copilot")
local copilot_suggestion = require("copilot.suggestion")
copilot.setup({
  filetypes = {
    sh = function() return not string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") end,
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = {
      accept = "<C-c>",
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-e>",
    },
  },
})

map("n", "<Leader>at", function() copilot_suggestion.toggle_auto_trigger() end, "Toggle autocompletion")

local codecompanion = require("codecompanion")
codecompanion.setup()

map({ "n", "v" }, "<Leader>ac", "<Cmd>CodeCompanionChat Toggle<CR>", "Chat")
map({ "n", "v" }, "<Leader>aa", "<Cmd>CodeCompanionActions<CR>", "Actions")
map("v", "<Leader>aq", function() vim.cmd("'<,'>CodeCompanion " .. (vim.fn.input("Ask: ") or "")) end, "Ask")
