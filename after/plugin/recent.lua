local dart = require("dart")

dart.setup({
  marklist = {},
  buflist = { "1", "2", "3" },
  mappings = {
    mark = "",
    jump = "",
    pick = ";,",
    next = "",
    prev = "",
  },
})

local mark = function(char)
  if not char then return end

  local current_buf_state = dart.state_from_filename(vim.api.nvim_buf_get_name(0))
  if current_buf_state then dart.unmark({ type = "marks", marks = { current_buf_state.mark } }) end

  local mark_state = dart.state_from_mark(char)
  if mark_state then dart.unmark({ type = "marks", marks = { mark_state.mark } }) end

  dart.mark(nil, char)
end

local jump_or_mark = function(char)
  local mark_exists = dart.state_from_mark(char)
  if mark_exists then
    dart.jump(char)
  else
    mark(char)
  end
end

local next_char = function(pattern)
  if not pattern then pattern = "^%w$" end

  local char_code = vim.fn.getchar(-1, { hide = true })
  if type(char_code) ~= "number" then return nil end

  local char = vim.fn.nr2char(char_code)
  if not char:match(pattern) then return nil end

  return char
end

map("n", ";;", function() mark(next_char()) end, "Mark")

map("n", ";", function() jump_or_mark(next_char()) end, "Mark or jump")
