return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      term_colors = true,
      styles = {
        comments = { "italic" },
        functions = { "bold" },
        keywords = { "bold" },
        booleans = { "bold" },
      },
      custom_highlights = function(colors)
        return {
          Pmenu = { bg = colors.base },
          NormalFloat = { bg = colors.base },
          TreesitterContext = { bg = colors.crust },
          FloatBorder = { bg = colors.base },
        }
      end,
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    opts = {
      bold_keywords = true,
      bright_border = true,
      cursorline = {
        bold = true,
        theme = "light",
        blend = 0.4,
      },
      on_highlight = function(highlights, palette)
        highlights.LspReferenceText = {
          bg = palette.gray2,
        }
        highlights.LspReferenceRead = {
          bg = palette.gray2,
        }
        highlights.LspReferenceWrite = {
          bg = palette.gray2,
        }
      end,
    },
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    opts = {
      style = "darker",
    },
  },
}
