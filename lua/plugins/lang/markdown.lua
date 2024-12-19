return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
      render_modes = true,
      heading = {
        position = "inline",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      table.insert(opts.sources, {
        name = "render-markdown",
        group_index = 2,
      })
    end,
  },
}
