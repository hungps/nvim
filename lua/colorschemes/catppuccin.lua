return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      integrations = {
        alpha = true,
        cmp = true,
        lsp_trouble = true,
        mason = true,
        native_lsp = true,
        neotest = true,
        treesitter = true,
        which_key = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
