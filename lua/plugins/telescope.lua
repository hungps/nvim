return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find [F]ile" },
      { "<leader><leader>", "<leader>ff", desc = "which_key_ignore", remap = true },
      { "<leader>fe", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find [E]verything" },
      { "<leader>ss", "<cmd>Telescope live_grep<CR>", desc = "Search [S]tring" },
      { "<leader>sf", "<cmd>Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<CR>", desc = "Search in current [F]ile" },
      { "<leader>?", "<cmd>Telescope help_tags<CR>", desc = "[H]elp" },
    },
    opts = function()
      local actions = require "telescope.actions"

      return {
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
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)

      require("telescope").load_extension "fzf"
    end,
  },
}
