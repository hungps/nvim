add({
  source = "L3MON4D3/LuaSnip",
  checkout = "v2.4.0",
  hooks = {
    post_install = function() vim.cmd([[make install_jsregexp]]) end,
  },
}, function()
  local ls = require("luasnip")

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
end)

add({ source = "saghen/blink.cmp", checkout = "v1.6.0" }, function()
  local blink = require("blink.cmp")

  blink.setup({
    snippets = { preset = "luasnip" },
    sources = {
      default = { "snippets", "lsp", "path" },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        "exact",
        "score",
        "sort_text",
        "kind",
      },
    },
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    cmdline = { enabled = false },
    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },
      list = {
        selection = { preselect = true, auto_insert = false },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "source_name", gap = 1 } },
        },
        scrollbar = false,
      },
      documentation = {
        auto_show = true,
        window = {
          scrollbar = false,
        },
      },
      ghost_text = { enabled = false },
    },
    signature = {
      enabled = true,
      window = {
        scrollbar = false,
        treesitter_highlighting = true,
        show_documentation = true,
      },
    },
  })
end)
