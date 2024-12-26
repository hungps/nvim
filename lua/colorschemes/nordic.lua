return {
  {
    "AlexvZyl/nordic.nvim",
    opts = {
      cursorline = {
        theme = "dark",
      },
      bold_keywords = true,
    },
    config = function(_, opts)
      require("nordic").setup(opts)
      require("nordic").load()
    end,
  },
}
