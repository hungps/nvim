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
