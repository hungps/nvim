return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
      { "jvgrootveld/telescope-zoxide", dependencies = "nvim-lua/popup.nvim" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find [F]ile" },
      { "<leader><leader>", "<leader>ff", desc = "which_key_ignore", remap = true },
      { "<leader>fd", "<cmd>Telescope zoxide list<CR>", desc = "[F]ind [D]irectory" },
      { "<leader>fe", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find [E]verything" },
      { "<leader>ss", "<cmd>Telescope live_grep<CR>", desc = "Search [S]tring" },
      { "<leader>sf", "<cmd>Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<CR>", desc = "Search in current [F]ile" },
      { "<leader>?", "<cmd>Telescope help_tags<CR>", desc = "[H]elp" },
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
          "filename_first",
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      require("telescope").load_extension "fzf"
      require("telescope").load_extension "zoxide"
    end,
  },
}
