return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find [F]ile" },
      { "<leader><leader>", "<leader>ff", desc = "which_key_ignore", remap = true },
      { "<leader>fh", "<cmd>Telescope oldfiles<CR>", desc = "Find previously opened file ([H]istory)" },
      { "<leader>ss", "<cmd>Telescope live_grep<CR>", desc = "Search [S]tring (grep)" },
      { "<leader>H", "<cmd>Telescope help_tags<CR>", desc = "[H]elp" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.6,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          preview_cutoff = 120,
        },
        path_display = {
          "truncate",
          filename_first = {
            reverse_directories = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      require("telescope").load_extension "fzf"
    end,
  },
}
