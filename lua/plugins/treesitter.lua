return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    opts = {
      ensure_installed = { "vim", "vimdoc" },
      auto_install = false,
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = {},
      },
      textobjects = {
        select = {
          enable = true,
          disable = {},
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select around function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function" },
            ["ac"] = { query = "@class.outer", desc = "Select around class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner class" },
            ["al"] = { query = "@loop.outer", desc = "Select around loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
            ["aa"] = { query = "@parameter.outer", desc = "Select around parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter/argument" },
            ["ad"] = { query = "@comment.outer", desc = "Select around comment/document" },
            ["id"] = { query = "@comment.inner", desc = "Select inner comment/document" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select around language scope" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        line_numbers = true,
      })
    end,
  },
}
