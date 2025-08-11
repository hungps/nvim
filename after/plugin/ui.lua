require("mini.starter").setup()
require("mini.icons").setup()
require("fidget").setup()

local clue = require("mini.clue")
clue.setup({
  clues = {
    { mode = "n", keys = "<leader>a", desc = "+AI" },
    { mode = "n", keys = "<leader>b", desc = "+Buffer" },
    { mode = "n", keys = "<leader>c", desc = "+Code" },
    { mode = "v", keys = "<leader>c", desc = "+Code" },
    { mode = "n", keys = "<leader>d", desc = "+Debug" },
    { mode = "n", keys = "<leader>f", desc = "+Find" },
    { mode = "n", keys = "<leader>g", desc = "+Git" },
    { mode = "n", keys = "<leader>q", desc = "+Quit" },
    { mode = "n", keys = "<leader>t", desc = "+Toggle" },
    { mode = "n", keys = "<leader>v", desc = "+Visits" },
    { mode = "n", keys = "<leader>x", desc = "+Diagnostics" },
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers({ show_contents = true }),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
  },
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "i", keys = "<C-x>" },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },
    { mode = "n", keys = "<C-w>" },
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    { mode = "n", keys = "'" },
    { mode = "x", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "`" },
    { mode = "n", keys = "'" },
    { mode = "x", keys = "'" },
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
    { mode = "n", keys = "]" },
    { mode = "n", keys = "[" },
    { mode = "o", keys = "i" },
    { mode = "x", keys = "i" },
    { mode = "o", keys = "a" },
    { mode = "x", keys = "a" },
    -- { mode = "n", keys = "s" },
    -- { mode = "x", keys = "s" },
    -- { mode = "x", keys = "X" },
  },
  window = {
    delay = 100,
    config = {
      width = "auto",
    },
  },
})

local hipatterns = require("mini.hipatterns")
local hi_words = require("mini.extra").gen_highlighter.words

hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
    todo = hi_words({ "TODO", "TO-DO" }, "MiniHipatternsTodo"),
    fixme = hi_words({ "FIXME" }, "MiniHipatternsFixme"),
    hack = hi_words({ "HACK" }, "MiniHipatternsHack"),
    note = hi_words({ "NOTE" }, "MiniHipatternsNote"),
    censor = {
      pattern = {
        "password:()%S+()",
      },
      extmark_opts = function(_, match, _)
        local mask = string.rep("•", vim.fn.strchars(match))
        return {
          virt_text = { { mask, "Comment" } },
          virt_text_pos = "overlay",
          priority = 200,
          right_gravity = false,
        }
      end,
    },
  },
})

local statusline = require("mini.statusline")
statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 9999 })
      local git = statusline.section_git({ trunc_width = 40 })
      local diagnostics = statusline.section_diagnostics({
        trunc_width = 75,
        icon = "",
        signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " },
      })
      local filename = statusline.section_filename({ trunc_width = 9999 })
      local fileinfo = statusline.section_fileinfo({ trunc_width = 9999 })
      local lsp = statusline.section_lsp({})
      local diff = statusline.section_diff({})
      local location = statusline.section_location({ trunc_width = 75 })
      local search_count = statusline.section_searchcount({})

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename, diff } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFilename", strings = { search_count, diagnostics } },
        { hl = "MiniStatuslineFileinfo", strings = { lsp, fileinfo } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
  set_vim_settings = false,
})
