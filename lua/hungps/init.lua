local groups = {
  vim.api.nvim_get_runtime_file("lua/hungps/core/*.lua", true),
  vim.api.nvim_get_runtime_file("lua/hungps/plugins/*.lua", true),
  vim.api.nvim_get_runtime_file("lua/hungps/plugins/*/*.lua", true),
}

for _, files in ipairs(groups) do
  for _, file in ipairs(files) do
    loadfile(file)()
  end
end
