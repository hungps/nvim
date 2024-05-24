return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      open_cmd = "noswapfile vnew",
    },
    keys = {
      -- stylua: ignore start
      { "<leader>sr", "<cmd>Spectre open<CR>", desc = "Search and [R]eplace" },
      { "<leader>sw", "<cmd>Spectre open_visual select_word=true<CR>", desc = "Search current [W]ord", mode = { "n", "v" } },
      { "<leader>sf", "<cmd>Spectre open_file_search select_word=true<CR>", desc = "Search on current [F]ile" },
    },
  },
}
