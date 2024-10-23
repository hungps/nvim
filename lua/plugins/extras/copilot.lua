return {
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
      },
    },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    -- TODO: Replacing "xzbdmw/nvim-cmp" with "hrsh7th/nvim-cmp"
    -- https://github.com/hrsh7th/nvim-cmp/pull/1955
    "xzbdmw/nvim-cmp",
    event = "InsertEnter",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        max_item_count = 3,
      })

      opts.sorting = opts.sorting or {}
      opts.sorting.priority_weight = opts.sorting.priority_weight or 2
      opts.sorting.comparators = opts.sorting.comparators or {}
      table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
}
