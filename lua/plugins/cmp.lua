return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets" },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "exact",
          "score",
          "sort_text",
        },
      },
      keymap = { preset = "default" },
      cmdline = { enabled = false },
      completion = {
        accept = {
          auto_brackets = { enabled = false },
        },
        list = {
          selection = { preselect = true, auto_insert = false },
        },
        menu = {
          draw = { treesitter = { "lsp" } },
          scrollbar = false,
        },
        documentation = {
          auto_show = true,
          window = {
            scrollbar = false,
          },
        },
        ghost_text = { enabled = false },
      },
      signature = {
        enabled = true,
        window = {
          scrollbar = false,
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      opts.capabilities = opts.capabilities or {}
      opts.capabilities.cmp = require("blink.cmp").get_lsp_capabilities()
    end,
  },
}
