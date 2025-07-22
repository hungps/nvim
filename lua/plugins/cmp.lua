return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        opts = {
          update_events = { "TextChanged", "TextChangedI" },
        },
        config = function(_, opts)
          require("luasnip").setup(opts)
          require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
        end,
      },
    },
    opts = {
      snippets = { preset = "luasnip" },
      sources = {
        default = { "snippets", "lsp", "path" },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "exact",
          "score",
          "sort_text",
          "kind",
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
          draw = {
            treesitter = { "lsp" },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "source_name", gap = 1 } },
            components = {
              kind_icon = {
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
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
