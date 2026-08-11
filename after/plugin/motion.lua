require("mini.jump").setup()

local jump2d = require("mini.jump2d")
jump2d.setup({
  spotter = jump2d.gen_spotter.pattern("[^%s%p]+"),
  labels = "arstgmneio",
  view = { dim = true, n_steps_ahead = 2 },
  mappings = {
    start_jumping = "<Leader><Leader>",
  },
})

local ai = require("mini.ai")
local gen_spec = ai.gen_spec
local gen_spec_extra = require("mini.extra").gen_ai_spec
ai.setup({
  custom_textobjects = {
    c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
    d = gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    F = gen_spec.function_call({ name_pattern = "[%w_]" }),
    B = gen_spec_extra.buffer(),
  },
})
