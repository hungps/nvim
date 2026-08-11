local blink = require("blink.cmp")

blink.setup({
  sources = {
    default = { "snippets", "lsp", "path", "buffer" },
    providers = {
      snippets = { min_keyword_length = 3 },
      buffer = { min_keyword_length = 5, max_items = 3 },
    },
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
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
  },
  cmdline = { enabled = false },
  completion = {
    trigger = {
      show_on_keyword = true,
      show_on_backspace = true,
      show_on_backspace_in_keyword = true,
      show_on_insert = true,
    },
    accept = {
      auto_brackets = { enabled = false },
    },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
        columns = {
          { "kind_icon",        "label", gap = 1 },
          { "label_description" }
        },
      },
      scrollbar = false,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
      window = {
        scrollbar = false,
      },
    },
    ghost_text = { enabled = false },
    keyword = { range = "full" },
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
