return {
  {
    "AlexvZyl/nordic.nvim",
    opts = {
      cursorline = {
        theme = "dark",
      },
      bold_keywords = true,
      bright_border = true,
    },
    config = function(_, opts)
      require("nordic").setup(opts)
      require("nordic").load()
    end,
  },
}
