return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        opts = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.customsnippetspath })
          require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.customsnippetspath })

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
    opts = function()
      local cmp = require("cmp")
      local types = require("cmp.types")

      return {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "luasnip" },
          { name = "path" },
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,
            function(entry1, entry2)
              local kind_scores = {
                Property = 1,
                Variable = 2,
                Snippet = 3,
                Field = 4,
                Method = 5,
                Constructor = 6,
                Function = 7,
                Class = 8,
                Interface = 9,
                Module = 10,
                Unit = 11,
                Value = 12,
                Enum = 13,
                Keyword = 14,
                Color = 16,
                File = 17,
                Reference = 18,
                Folder = 19,
                EnumMember = 20,
                Constant = 21,
                Struct = 22,
                Event = 23,
                Operator = 24,
                TypeParameter = 25,
                Text = 26,
              }
              local kind1 = types.lsp.CompletionItemKind[entry1:get_kind()]
              local kind2 = types.lsp.CompletionItemKind[entry2:get_kind()]

              local diff = kind_scores[kind1] - kind_scores[kind2]

              if diff == 0 then
                return nil
              end

              return diff < 0
            end,
            cmp.config.compare.locality,
            cmp.config.compare.exact,
            cmp.config.compare.order,
          },
        },
        -- experimental = {
        --   ghost_text = true,
        -- },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<C-l>"] = cmp.mapping(function(fallback)
            if require("luasnip").expand_or_locally_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-h>"] = cmp.mapping(function(fallback)
            if require("luasnip").locally_jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<Esc>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
              vim.cmd("stopinsert")
            else
              fallback()
            end
          end, { "i" }),
        }),
        window = {
          completion = {
            winhighlight = "Normal:NormalFloat,CursorLine:Visual",
          },
          documentation = {
            winhighlight = "Normal:NormalFloat,CursorLine:Visual",
          },
        },
        view = {
          entries = {
            follow_cursor = true,
          },
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    opts = function(_, opts)
      opts.capabilities = opts.capabilities or {}
      opts.capabilities.cmp = require("cmp_nvim_lsp").default_capabilities()
    end,
  },
}
