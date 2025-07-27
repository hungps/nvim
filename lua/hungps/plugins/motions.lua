return {
  { "echasnovski/mini.jump", opts = {} },
  {
    "echasnovski/mini.ai",
    dependencies = {
      "echasnovski/mini.extra",
    },
    opts = function()
      local gen_spec = require("mini.ai").gen_spec
      local gen_spec_extra = require("mini.extra").gen_ai_spec

      return {
        custom_textobjects = {
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
}
