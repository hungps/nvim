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
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return end

  vim.system({ "qlmanage", "-p", path }, {}, function(result)
    if result.code ~= 0 then
      vim.notify("'qlmanage -p' failed with code: " .. result.code)
      vim.notify("Stderr:\n" .. result.stderr)
    end
  end)
end

map("n", "<Leader>fe", function() open(vim.api.nvim_buf_get_name(0)) end, "File explorer")
map("n", "<Leader>fE", function() open(vim.uv.cwd()) end, "File explorer (cwd)")

autocmd("MiniFiles keymaps", augroup("MiniFilesKeymaps"), "User", "MiniFilesBufferCreate", function(ev)
  local buffer = ev.data.buf_id

  map("n", "g~", function() set_root(entry_dir_path()) end, "Set as root", { buffer = buffer })
  map("n", "gy", function() yank(entry_path()) end, "Yank path", { buffer = buffer })
  map("n", "gY", function() yank(entry_dir_path()) end, "Yank parent dir path", { buffer = buffer })
  map("n", "go", function() system_open(entry_path()) end, "Open in System", { buffer = buffer })
  map("n", "gO", function() system_open(entry_dir_path()) end, "Open parent dir in System", { buffer = buffer })
  map("n", "g.", toggle_hidden_files, "Toggle hidden files", { buffer = buffer })
  map("n", "gl", preview_file, "Quick Look", { buffer = buffer })
end)
