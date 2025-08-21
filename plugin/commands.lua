-- stylua: ignore start

--- @param desc string
--- @param name string
--- @param command string|fun(args: vim.api.keyset.create_user_command.command_args)
--- @param opts? vim.api.keyset.user_command
_G.command = function(name, desc, command, opts)
  opts = opts or {}
  opts.desc = desc
  return vim.api.nvim_create_user_command(name, command, opts)
end

command("Scratch", "Open scratch buffer", function()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
end)

command("BufCloseHidden", "Close hidden buffers", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })

  for _, buf in ipairs(bufs) do
    if buf.changed == 0 and (not buf.windows or #buf.windows == 0) then
      print(("Deleting buffer %d : %s"):format(buf.bufnr, buf.name))
      vim.api.nvim_buf_delete(buf.bufnr, { force = false, unload = false })
    end
  end
end)
