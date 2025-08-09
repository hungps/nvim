local ls = require("luasnip")

autocmd("Install jsregexp on update", augroup("LuasnipUpdated"), "PackChanged", "*", function(ev)
  local spec = ev.data.spec
  if spec and spec.name == "luasnip" and ev.data.kind == "update" then
    vim.notify("luasnip was updated, running make install_jsregexp", vim.log.levels.INFO)
    vim.cmd("make install_jsregexp")
  end
end)

ls.setup({
  update_events = { "TextChanged", "TextChangedI" },
  keep_roots = true,
  link_roots = true,
  exit_roots = true,
  link_children = true,
  delete_check_events = "TextChanged",
  ext_base_prio = 300,
  ext_prio_increase = 1,
  enable_autosnippets = true,
})

require("luasnip.loaders.from_lua").load({ paths = { Config.snippets_path } })

map({ "i", "s" }, "<C-l>", function()
  if ls.locally_jumpable(1) then ls.jump(1) end
end)
map({ "i", "s" }, "<C-h>", function()
  if ls.locally_jumpable(-1) then ls.jump(-1) end
end)
map({ "i", "s" }, "<C-j>", function()
  if ls.choice_active() then ls.change_choice(1) end
end)
map({ "i", "s" }, "<C-k>", function()
  if ls.choice_active() then ls.change_choice(-1) end
end)
