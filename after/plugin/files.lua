local files = require("mini.files")

local filter = function(fs_entry)
  for _, pattern in ipairs(Config.hidden_file_patterns) do
    if fs_entry.name:match(pattern) then return false end
  end

  return true
end

files.setup({
  content = {
    filter = filter,
  },
  options = {
    permanent_delete = false,
  },
  windows = {
    preview = true,
    width_preview = 60,
  },
})

local set_root, system_open = vim.fn.chdir, vim.ui.open
local yank = function(text) vim.fn.setreg(vim.v.register, text) end

local open = function(path)
  if vim.loop.fs_stat(path) then
    files.open(path)
  else
    files.open(vim.uv.cwd())
  end
end

local trash_path = function() return vim.fn.stdpath("data") .. "/mini.files/trash" end
local entry_path = function() return (files.get_fs_entry() or {}).path end
local entry_dir_path = function() return vim.fs.dirname(entry_path()) end

local toggle_hidden_files = function()
  vim.g.minifiles_show_hidden_file = not vim.g.minifiles_show_hidden_file
  files.refresh({ content = { filter = vim.g.minifiles_show_hidden_file and filter or nil } })
end

local preview_file = function()
  local path = (files.get_fs_entry() or {}).path
  if path == nil then return end

  vim.system({ "qlmanage", "-p", path }, {}, function(result)
    if result.code ~= 0 then
      vim.notify("'qlmanage -p' failed with code: " .. result.code)
      vim.notify("Stderr:\n" .. result.stderr)
    end
  end)
end

local open_split = function(direction)
  local cur_target = files.get_explorer_state().target_window
  local new_target = vim.api.nvim_win_call(cur_target, function()
    vim.cmd(direction .. ' split')
    return vim.api.nvim_get_current_win()
  end)

  files.set_target_window(new_target)
end

local set_mark = function(id, path, desc)
  files.set_bookmark(id, path, { desc = desc })
end

map("n", "<Leader>fe", function() open(vim.api.nvim_buf_get_name(0)) end, "File explorer")
map("n", "<Leader>fE", function() open(vim.uv.cwd()) end, "File explorer (cwd)")

autocmd("MiniFiles bookmarks", augroup("MiniFilesBookmarks"), "User", "MiniFilesExplorerOpen", function()
  set_mark("c", vim.fn.stdpath("config"), "Config")
  set_mark("d", vim.fn.stdpath("data"), "Data")
  set_mark("w", vim.fn.getcwd(), "Working dir")
  set_mark("t", trash_path(), "Trash")
  set_mark("~", "~", "Home")
  set_mark(".", "~/.dotfiles", "Dotfiles")
  set_mark("D", "~/Downloads", "Downloads")
  set_mark("S", "~/Sources", "Sources")
end)

autocmd("MiniFiles keymaps", augroup("MiniFilesKeymaps"), "User", "MiniFilesBufferCreate", function(ev)
  local buffer = ev.data.buf_id

  local fmap = function(mode, lhs, rhs, desc)
    map(mode, lhs, rhs, desc, { buf = buffer })
  end

  fmap("n", "gh", files.show_help, "Show help")
  fmap("n", "g~", function() set_root(entry_dir_path()) end, "Set as root")
  fmap("n", "gy", function() yank(entry_path()) end, "Yank path")
  fmap("n", "gY", function() yank(entry_dir_path()) end, "Yank parent dir path")
  fmap("n", "go", function() system_open(entry_path()) end, "Open in System")
  fmap("n", "gO", function() system_open(entry_dir_path()) end, "Open parent dir in System")
  fmap("n", "g.", toggle_hidden_files, "Toggle hidden files")
  fmap("n", "gv", preview_file, "Quick Look")
  fmap("n", "<C-l>", function() open_split("belowright horizontal") end, "Split horizontal")
  fmap("n", "<C-j>", function() open_split("belowright vertical") end, "Split vertical")
  fmap("n", "<C-t>", function() open_split("tab") end, "Split to new tab")

  local has_clue, clue = pcall(require, "mini.clue")
  if has_clue then
    clue.ensure_buf_triggers(buffer)
  end
end)
