local copilot = require("copilot")
local copilot_suggestion = require("copilot.suggestion")

copilot.setup({
  should_attach = function(_, bufname)
    if string.match(bufname, "env") then
      return false
    end

    return true
  end,
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 300,
    keymap = {
      accept = "<C-c>",
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-e>",
    },
    disable_limit_reached_message = true,
    logger = {
      file_log_level = vim.log.levels.OFF,
      print_log_level = vim.log.levels.OFF,
    },
  },
})

map("n", "<Leader>at", copilot_suggestion.toggle_auto_trigger, "Toggle autocomplete")

-- local _99 = require("99")
--
-- _99.setup({
--   provider = _99.Providers.OpenCodeProvider,
--   model = "neuralwatt/glm-5.2-fast",
--   logger = {
--     level = _99.DEBUG,
--     path = "/tmp/" .. vim.fs.basename(vim.uv.cwd()) .. ".99.debug",
--     print_on_error = true,
--   },
-- })
--
-- map("v", "<Leader>av", function() _99.visual({}) end, "Prompt with visual selection")
-- map("n", "<Leader>ax", function() _99.stop_all_requests() end, "Stop all requests")
-- map("n", "<Leader>as", function() _99.search({}) end, "Search")
