return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sources.default, 1, "lazydev")

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers["lazydev"] = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "lua", "luadoc" }) end,
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts) table.insert(opts.formatters, "stylua") end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
