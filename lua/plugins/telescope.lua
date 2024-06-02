return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find [F]ile" },
      { "<leader><leader>", "<leader>ff", desc = "which_key_ignore", remap = true },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find [A]ll files" },
      { "<leader>ss", "<cmd>Telescope live_grep<CR>", desc = "Search [S]tring" },
      { "<leader>?", "<cmd>Telescope help_tags<CR>", desc = "[H]elp" },
    },
    opts = function()
      local actions = require "telescope.actions"

      return {
        defaults = {
          prompt_prefix = "   ",
          layout_strategy = "vertical",
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
