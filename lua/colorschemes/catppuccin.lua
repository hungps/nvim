return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      term_colors = true,
      dim_inactive = {
        enabled = true,
      },
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = { "bold" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        dap = true,
        overseer = true,
        render_markdown = true,
        treesitter = true,
        lsp_trouble = true,
        which_key = true,
        snacks = { enabled = true },
        mini = { enabled = true },
      },
      custom_highlights = function(colors)
        return {
          Pmenu = { bg = colors.base },
          NormalFloat = { bg = colors.base },
          TreesitterContext = { bg = colors.crust },
        }
      end,
    },
    init = function() vim.cmd.colorscheme("catppuccin") end,
  },
}
