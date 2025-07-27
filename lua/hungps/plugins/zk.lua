return {
  {
    "zk-org/zk-nvim",
    name = "zk",
    keys = {
      { "<leader>n", desc = "+Notes" },
      { "<leader>nn", "<Cmd>ZkNew<CR>", desc = "New note" },
      { "<leader>nf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "Find notes" },
      { "<leader>nt", "<Cmd>ZkTags<CR>", desc = "Find tags" },
      { "<leader>nn", desc = "+New note", mode = "v" },
      { "<leader>nnt", ":'<,'>ZkNewFromTitleSelection<CR>", desc = "New note (selected as title)", mode = "v" },
      { "<leader>nnc", ":'<,'>ZkNewFromContentSelection<CR>", desc = "New note (selected as content)", mode = "v" },
    },
    opts = {},
    config = function(_, opts)
      require("zk").setup(opts)

      if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
        vim.keymap.set("n", "<leader>nb", "<Cmd>ZkBacklinks<CR>", { desc = "Find backlinks" })
        vim.keymap.set("n", "<leader>nl", "<Cmd>ZkLinks<CR>", { desc = "Find links" })
      end
    end,
  },
}
