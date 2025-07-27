return {
  {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    opts = function()
      local clue = require("mini.clue")

      return {
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
          { mode = "n", keys = "<leader>x", desc = "+Diagnostics" },

          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
        triggers = {
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          { mode = "i", keys = "<C-x>" },

          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          { mode = "n", keys = "'" },
          { mode = "x", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "`" },

          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          { mode = "n", keys = "<C-w>" },

          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          { mode = "n", keys = "]" },
          { mode = "n", keys = "[" },

          { mode = "o", keys = "i" },
          { mode = "x", keys = "i" },
          { mode = "o", keys = "a" },
          { mode = "x", keys = "a" },
        },
        window = {
          delay = 300,
        },
      }
    end,
  },
}
