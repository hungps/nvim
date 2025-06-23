return {
  {
    "echasnovski/mini.bracketed",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.jump",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "echasnovski/mini.extra",
    },
    opts = function()
      local gen_spec = require("mini.ai").gen_spec
      local gen_spec_extra = require("mini.extra").gen_ai_spec

      return {
        custom_textobjects = {
          -- Tweak function call to not detect dot in function name
          f = gen_spec.function_call({ name_pattern = "[%w_]" }),
          F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
          d = gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
          B = gen_spec_extra.buffer(),
          D = gen_spec_extra.diagnostic(),
          I = gen_spec_extra.indent(),
          L = gen_spec_extra.line(),
          N = gen_spec_extra.number(),
        },
      }
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "cw", "ce", mode = { "n" }, remap = true },
    },
    opts = {
      skipInsignificantPunctuation = true,
      consistentOperatorPending = false,
      subwordMovement = true,
    },
  },
}
