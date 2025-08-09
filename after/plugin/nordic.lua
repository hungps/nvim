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
