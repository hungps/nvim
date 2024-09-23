return {
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = {
      content = {
        active = function()
          local MiniStatusline = require("mini.statusline")
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 9999 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diagnostics = MiniStatusline.section_diagnostics({
            trunc_width = 75,
            icon = "",
            signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " },
          })
          local filename = MiniStatusline.section_filename({ trunc_width = 9999 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 9999 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFilename", strings = { diagnostics } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { location } },
          })
        end,
      },
      set_vim_settings = false,
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      draw = {
        animation = function()
          return 1
        end,
      },
      symbol = "│",
    },
  },
  {
    "echasnovski/mini.hipatterns",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "echasnovski/mini.extra",
    },
    opts = function()
      local hipatterns = require("mini.hipatterns")
      local hi_words = require("mini.extra").gen_highlighter.words
      return {
        highlighters = {
          todo = hi_words({ "TODO" }, "MiniHipatternsTodo"),
          fixme = hi_words({ "FIXME" }, "MiniHipatternsFixme"),
          hack = hi_words({ "HACK" }, "MiniHipatternsHack"),
          note = hi_words({ "NOTE" }, "MiniHipatternsNote"),
          censor = {
            pattern = {
              "password:()%S+()",
            },
            group = "",
            extmark_opts = function(_, match, _)
              local mask = string.rep("•", vim.fn.strchars(match))
              return {
                virt_text = {
                  { mask, "Comment" },
                },
                virt_text_pos = "overlay",
                priority = 200,
                right_gravity = false,
              }
            end,
          },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        start_in_insert = false,
      },
      select = {
        builtin = {
          win_options = {
            winhighlight = "Normal:NormalFloat,CursorLine:Visual",
          },
        },
      },
    },
  },
}
