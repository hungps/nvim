local zk = require("zk")

zk.setup({})

map("n", "<leader>n", "<nop>", "+Note")
map("n", "<leader>nn", "<Cmd>ZkNew<CR>", "New note")
map("v", "<leader>nn", ":'<,'>ZkNewFromTitleSelection<CR>", "New note as title")
map("v", "<leader>nN", ":'<,'>ZkNewFromContentSelection<CR>", "New note as content")
map("n", "<leader>nf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Find notes")
map("n", "<leader>no", "<Cmd>ZkNotes { orphan = true }<CR>", "Find orphans")
map("v", "<leader>nf", ":'<,'>ZkMatch<CR>", "Find matching visual selection")
map("n", "<leader>nt", "<Cmd>ZkTags<CR>", "Find by tag")

autocmd("Markdown zk keymaps", augroup("ZkMdKeymaps"), "FileType", "markdown", function()
  if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
    map("n", "<leader>nb", "<Cmd>ZkBacklinks<CR>", "Find backlink")
    map("n", "<leader>nl", "<Cmd>ZkLinks<CR>", "Open linked")
  end
end)
