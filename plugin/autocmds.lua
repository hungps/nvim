-- stylua: ignore start

--- @param desc string
--- @param group integer|string
--- @param event vim.api.keyset.events|vim.api.keyset.events[]
--- @param pattern string|string[]|integer Autocmd pattern or buffer id
--- @param callback string|(fun(args?: vim.api.keyset.create_autocmd.callback_args): boolean?)
--- @param opts? vim.api.keyset.create_autocmd
_G.autocmd = function(desc, group, event, pattern, callback, opts)
  opts = vim.tbl_extend("error", opts or {}, {
    group = group,
    desc = desc,
    callback = callback,
  })

  if type(pattern) == "number" then
    opts.buffer = pattern
  else
    ---@diagnostic disable-next-line: assign-type-mismatch
    opts.pattern = pattern
  end

  vim.api.nvim_create_autocmd(event, opts)
end

--- @param name string
--- @param clear? boolean
--- @return integer
_G.augroup = function(name, clear) return vim.api.nvim_create_augroup("User" .. name, { clear = clear }) end

local group = augroup("custom-autocmds")

autocmd('Highlight yanked text', group, 'TextYankPost', '*', function()
  vim.hl.on_yank()
end)

autocmd('Show relative line numbers', group, 'ModeChanged', 'n:[nvox]*', function()
  vim.wo.relativenumber = vim.wo.number
end)

autocmd('Hide relative line numbers', group, 'ModeChanged', '*:[ni]', function()
  vim.wo.relativenumber = false
end)

autocmd('Reload file when changed', group, { 'FocusGained', 'TermClose', 'TermLeave' }, '*', function()
  if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
end)

autocmd('Diagnostic popup on hover', augroup('diagnostic-float'), 'CursorHold', '*', function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
    source = true,
    scope = 'line',
    severity_sort = true,
  })
end)

autocmd('Open file at the last position', group, 'BufReadPost', '*', function()
  local mark = vim.api.nvim_buf_get_mark(0, '"')
  if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
    vim.api.nvim_win_set_cursor(0, mark)
    vim.schedule(function() vim.cmd("norm! zz") end)
  end
end)

autocmd("Terminal settings", group, "TermOpen", "*", function()
  vim.opt_local.statuscolumn = ""
  vim.cmd([[startinsert]])
end)

autocmd("Close terminal buffer on exit with status 0", group, "TermClose", "*", function()
  vim.schedule(function()
    if vim.bo.buftype == 'terminal' and vim.v.event.status == 0 then
      vim.cmd("bdelete! " .. vim.fn.expand("<abuf>"))
    end
  end)
end)
