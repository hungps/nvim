return {
  {
    "ahmedkhalf/project.nvim",
    keys = {
      { "<leader>wo", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
    opts = {},
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      require("telescope").load_extension "projects"
    end,
  },
}
