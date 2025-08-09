require("catppuccin").setup({
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
  -- float = { transparent = false, solid = true },
})

