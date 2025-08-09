local state = { floating = {
  buf = -1,
  win = -1,
} }

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns)
  local height = opts.height or math.floor(vim.o.lines * 0.3)

  local col, row
  if opts.center then
    col = math.floor((vim.o.columns - width) / 2)
    row = math.floor((vim.o.lines - height) / 2)
  else
    col = 0
    row = math.floor(vim.o.lines - height)
  end

  local buf = opts.buf

  if not vim.api.nvim_buf_is_valid(buf) then buf = vim.api.nvim_create_buf(false, true) end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
  })

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then vim.cmd.terminal() end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("Term", toggle_terminal, {})

vim.keymap.set("n", "<Leader>tt", "<Cmd>Term<CR>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
