add({
  source = "echasnovski/mini.pick",
  depends = { "echasnovski/mini.extra" },
}, function()
  local pick = require("mini.pick")
  local extra = require("mini.extra")

  pick.setup({
    source = {
      choose = function(item)
        local matches = pick.get_picker_matches()

        if matches and next(matches.marked) then return pick.default_choose_marked(matches.marked) end

        return pick.default_choose(item)
      end,
    },
    mappings = {
      toggle_info = "<C-k>",
      mark = "<C-y>",
      mark_all = "<C-Y>",
    },
  })

  vim.ui.select = pick.ui_select

  map("n", "<Leader>ff", function() pick.builtin.files() end, "Find files")
  map("n", "<Leader>fg", function() pick.builtin.grep_live() end, "Find by grep")
  map("n", "<Leader>fr", function() pick.builtin.resume() end, "Resume latest find")
  map("n", "<Leader>fb", function() pick.builtin.buffers() end, "Find buffers")
  map("n", "<Leader>fh", function() pick.builtin.help() end, "Find help tags")
  map("n", "<Leader>fo", function() extra.pickers.oldfiles() end, "Find old files")
  map("n", "<Leader>f/", function() extra.pickers.history({ scope = "/" }) end, "Find search history")
  map("n", "<Leader>f:", function() extra.pickers.history({ scope = ":" }) end, "Find command history")
  map("n", "<Leader>fm", function() extra.pickers.marks() end, "Find marks")
  map("n", "<Leader>fk", function() extra.pickers.keymaps() end, "Find keymaps")
  map("n", "<Leader>fc", function() extra.pickers.commands() end, "Find commands")
  map("n", "<Leader>fH", function() extra.pickers.hl_groups() end, "Find highlights")
  map("n", "<Leader>ft", function() extra.pickers.colorschemes() end, "Find colorschemes")
  map("n", "<Leader>fj", function() extra.pickers.list({ scope = "jump" }) end, "Find jumplist")
  map("n", "<Leader>fl", function() extra.pickers.list({ scope = "location" }) end, "Find loclist")
  map("n", "<Leader>fq", function() extra.pickers.list({ scope = "quickfix" }) end, "Find qflist")

  map("n", "<Leader>gc", function() extra.pickers.git_commits() end, "Git commits")
  map("n", "<Leader>gb", function() extra.pickers.git_branches() end, "Git branches")
end)

add({
  source = "echasnovski/mini.visits",
  depends = { "echasnovski/mini.extra" },
}, function()
  local visits = require("mini.visits")
  local extra = require("mini.extra")

  visits.setup()

  map("n", "<Leader>fv", function() extra.pickers.visit_paths() end, "Find visit paths (cwd)")
  map("n", "<Leader>fV", function() extra.pickers.visit_paths({ cwd = "" }) end, "Find visit paths (all)")

  command("VisitsAddLabel", function() visits.add_label() end)
  command("VisitsRemoveLabel", function() visits.remove_label() end)
  command("VisitsSelectLabels", function() extra.pickers.visit_labels() end)
end)
