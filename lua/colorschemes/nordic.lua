return {
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
    config = function(_, opts)
      require("nordic").setup(opts)
      require("nordic").load()
    end,
  },
}
