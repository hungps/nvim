return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function()
      require("which-key").add({
        { "<leader>z", desc = "Zettelkasten" },
      })
    end,
  },
  {
    "zk-org/zk-nvim",
    name = "zk",
    opts = {
      picker = "snacks_picker",
    },
    config = function()
      local map = vim.keymap.set

      map("n", "<leader>zn", "<Cmd>ZkNew<CR>", { desc = "New note" })
      map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection<CR>", { desc = "New note (selected as title)" })
      map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection<CR>", { desc = "New note (selected as content)" })
      map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = "Find notes" })
      map("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "Find tags" })

      if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
        map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "Find backlinks" })
        map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "Find links" })
      end
    end,
  },
}
