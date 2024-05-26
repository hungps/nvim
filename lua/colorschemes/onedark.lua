return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    opts = function()
      local style = "dark"
      local colors = require("onedark.palette")[style]
      return {
        style = style,
        highlights = {
          -- Telescope
          TelescopeBorder = { fg = colors.bg_d },
          TelescopePromptNormal = { bg = colors.bg_d },
          TelescopePromptBorder = { fg = colors.bg_d, bg = colors.bg_d },
          TelescopePromptTitle = { fg = colors.bg2, bg = colors.red },
          TelescopeResultsNormal = { bg = colors.bg_d },
          TelescopeResultsBorder = { fg = colors.bg_d, bg = colors.bg_d },
          TelescopeResultsTitle = { fg = colors.bg_d, bg = colors.bg_d },
          TelescopePreviewNormal = { bg = colors.bg_d },
          TelescopePreviewBorder = { fg = colors.bg_d, bg = colors.bg_d },
          TelescopePreviewTitle = { fg = colors.bg2, bg = colors.green },
          TelescopeMatching = { fg = colors.orange, fmt = "bold" },
          TelescopePromptPrefix = { fg = colors.green },
          TelescopeSelection = { bg = colors.bg2 },
          TelescopeSelectionCaret = { fg = colors.yellow },
        },
      }
    end,
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        theme = "onedark",
      },
    },
  },
}
