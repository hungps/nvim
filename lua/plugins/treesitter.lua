return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = { "lua", "luadoc", "vim", "vimdoc" },
      auto_install = false,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          -- Temporaty disable because of performance reason
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/627
          enable = false,
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
    end,
  },
}
