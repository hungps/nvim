add({ source = "catppuccin/nvim", name = "catppuccin" }, function()
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
        FloatBorder = { bg = colors.base },
      }
    end,
    float = { transparent = false, solid = true },
  })
end)

add("AlexvZyl/nordic.nvim", function()
  require("nordic").setup({
    bold_keywords = true,
    bright_border = true,
    cursorline = {
      bold = true,
      theme = "light",
      blend = 0.4,
    },
    on_highlight = function(highlights, palette)
      highlights.LspReferenceText = { bg = palette.gray2 }
      highlights.LspReferenceRead = { bg = palette.gray2 }
      highlights.LspReferenceWrite = { bg = palette.gray2 }
      highlights.Pmenu = { bg = palette.bg }
      highlights.NormalFloat = { bg = palette.bg }
      highlights.FloatBorder = { bg = palette.bg }
    end,
  })
end)

vim.cmd.colorscheme("nordic")
