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
    },
  },
}
