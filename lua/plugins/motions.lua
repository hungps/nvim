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
    "echasnovski/mini.jump2d",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return {
        spotter = require("mini.jump2d").builtin_opts.word_start.spotter,
        view = {
          dim = true,
          n_steps_ahead = 2,
        },
        allowed_lines = {
          blank = false,
        },
      }
    end,
  },
}
