local function augroup(name) return vim.api.nvim_create_augroup("custom-" .. name, { clear = true }) end

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = augroup("highlight-yank"),
  callback = function() vim.highlight.on_yank() end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Reload file when changed",
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
})

autocmd({ "BufWritePre" }, {
  desc = "Auto create dir when saving a file",
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
