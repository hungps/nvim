return {
  {
    -- TODO: Replacing "xzbdmw/nvim-cmp" with "hrsh7th/nvim-cmp"
    -- https://github.com/hrsh7th/nvim-cmp/pull/1955
    "xzbdmw/nvim-cmp",
    branch = "dynamic",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- luasnip
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

      return {
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              return require("cmp.types").lsp.CompletionItemKind.Text ~= entry:get_kind()
            end,
          },
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
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            -- function(entry1, entry2)
            --   local _, entry1_under = entry1.completion_item.label:find("^_+")
            --   local _, entry2_under = entry2.completion_item.label:find("^_+")
            --   entry1_under = entry1_under or 0
            --   entry2_under = entry2_under or 0
            --   if entry1_under > entry2_under then
            --     return false
            --   elseif entry1_under < entry2_under then
            --     return true
            --   end
            -- end,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            -- cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        experimental = {
          ghost_text = true,
        },
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item/[p]revious item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept completion
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Close completion popup
          ["<C-e>"] = cmp.mapping.close(),

          -- Move to the right of each of the expansion locations.
          ["<C-l>"] = cmp.mapping(function(fallback)
            if require("luasnip").expand_or_locally_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Move to the left of each of the expansion locations.
          ["<C-h>"] = cmp.mapping(function(fallback)
            if require("luasnip").locally_jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Abort the completion
          ["<Esc>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
              vim.cmd("stopinsert")
            end

            fallback()
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
}
