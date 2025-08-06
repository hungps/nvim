add("echasnovski/mini.bracketed", function() require("mini.bracketed").setup() end)
add("echasnovski/mini.jump", function() require("mini.jump").setup() end)

add("echasnovski/mini.jump2d", function()
  local jump2d = require("mini.jump2d")

  jump2d.setup({
    spotter = jump2d.gen_spotter.pattern("[^%s%p]+"),
    labels = "arstgmneio",
    view = { dim = true, n_steps_ahead = 2 },
  })
end)

add({
  source = "echasnovski/mini.ai",
  depends = { "echasnovski/mini.extra" },
}, function()
  local gen_spec = require("mini.ai").gen_spec
  local gen_spec_extra = require("mini.extra").gen_ai_spec

  require("mini.ai").setup({
    custom_textobjects = {
      c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
      d = gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
      f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      F = gen_spec.function_call({ name_pattern = "[%w_]" }),
      B = gen_spec_extra.buffer(),
    },
  })
end)
