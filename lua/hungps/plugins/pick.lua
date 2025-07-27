return {
  {
    "echasnovski/mini.pick",
    dependencies = {
      "echasnovski/mini.extra",
    },
    keys = function()
      local builtin = require("mini.pick").builtin
      local extra = require("mini.extra").pickers

      return {
        { "<Leader>ff", function() builtin.files() end, desc = "Find files" },
        { "<Leader>fg", function() builtin.grep_live() end, desc = "Find by grep" },
        { "<Leader>fr", function() builtin.resume() end, desc = "Resume latest find" },
        { "<Leader>fb", function() builtin.buffers() end, desc = "Find buffers" },
        { "<Leader>fh", function() builtin.help() end, desc = "Find help tags" },
        { "<Leader>fo", function() extra.oldfiles() end, desc = "Find old files" },
        { "<Leader>fm", function() extra.marks() end, desc = "Find marks" },
        { "<Leader>fk", function() extra.keymaps() end, desc = "Find keymaps" },
        { "<Leader>fc", function() extra.commands() end, desc = "Find commands" },
        { "<Leader>fH", function() extra.hl_groups() end, desc = "Find highlights" },
        { "<Leader>ft", function() extra.colorschemes() end, desc = "Find colorschemes" },
        { "<Leader>fj", function() extra.list({ scope = "jump" }) end, desc = "Find jumplist" },
        { "<Leader>fl", function() extra.list({ scope = "location" }) end, desc = "Find loclist" },
        { "<Leader>fq", function() extra.list({ scope = "quickfix" }) end, desc = "Find qflist" },
        { "<Leader>gb", function() extra.git_branches() end, desc = "Git branches" },
        { "<Leader>fc", function() extra.git_commits() end, desc = "Git commits" },
      }
    end,
    opts = {},
    config = function(_, opts)
      local pick = require("mini.pick")

      pick.setup(opts)

      vim.ui.select = pick.ui_select
    end,
  },
}
