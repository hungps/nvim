return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",

      -- luasnip
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
            opts = {
              history = true,
              updateevents = "TextChanged,TextChangedI",
            },
            config = function(_, opts)
              require("luasnip").config.set_config(opts)
              require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.customsnippetspath }
              require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.customsnippetspath }

              vim.api.nvim_create_autocmd("InsertLeave", {
                callback = function()
                  if
                    require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                    and not require("luasnip").session.jump_active
                  then
                    require("luasnip").unlink_current()
                  end
                end,
              })
            end,
          },
        },
      },
    },
    opts = function()
      local cmp = require "cmp"
      local defaults = require "cmp.config.default"()
      local luasnip = require "luasnip"

      return {
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1, max_item_count = 5 },
          { name = "luasnip", priority = 2, max_item_count = 3 },
        }, {
          { name = "nvim_lua" },
          { name = "path" },
          { name = "buffer", max_item_count = 5 },
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sorting = defaults.sorting,
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item/[p]revious item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept completion
          ["<CR>"] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Close completion popup
          ["<C-e>"] = cmp.mapping.close(),

          -- Move to the right of each of the expansion locations.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),

          -- Move to the left of each of the expansion locations.
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        },
        completion = {
          completeopt = "menu,menuone",
        },
        experimental = {
          ghost_text = true,
        },
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    optional = true,
    opts = function(_, opts)
      opts.fast_wrap = {}
      opts.disable_filetype = vim.list_extend(opts.disable_filetype or {}, { "TelescopePrompt", "vim" })

      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
