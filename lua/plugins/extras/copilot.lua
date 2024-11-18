return {
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-Space>", "<Plug>(copilot-suggest)")
      vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-y>", "copilot#Accept('')", { expr = true, replace_keycodes = false })

      vim.g.copilot_no_tab_map = true
    end,
  },
}
