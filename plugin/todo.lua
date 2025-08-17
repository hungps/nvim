vim.api.nvim_create_user_command("Todo", function()
  local BASE_PATH = vim.fn.stdpath("data") .. "/todos"
  vim.fn.mkdir(BASE_PATH, "p")
  vim.cmd(string.format("15split | edit %s/%s.md", BASE_PATH, vim.fn.fnamemodify(vim.fn.getcwd(), ":t")))
end, {})
