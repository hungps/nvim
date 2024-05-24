local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new {
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "none",
    width = 100000,
    height = 100000,
    zindex = 200,
  },
  on_open = function(_)
    vim.cmd "startinsert!"
  end,
  on_close = function(_) end,
  count = 99,
}

local M = {}

function M.open()
  lazygit:toggle()
end

return M
