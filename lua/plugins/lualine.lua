return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          winbar = {
            "alpha",
            "lazy",
            "neo-tree",
            "dapui_breakpoints",
            "dapui_console",
            "dapui_scopes",
            "dapui_watches",
            "dapui_stacks",
            "dap-repl",
          },
        },
      },
      extensions = {
        "neo-tree",
        "lazy",
        "fzf",
        "mason",
        "nvim-dap-ui",
        "overseer",
        "quickfix",
        "toggleterm",
        "trouble",
        "oil",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
          },
        },
        lualine_b = {
          {
            "branch",
            formatter = function(name)
              return name:sub(1, 1)
            end,
          },
        },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = { "" },
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            path = 0,
          },
        },
        lualine_x = {
          {
            "diagnostics",
          },
        },
        lualine_y = {
          {
            "progress",
          },
        },
        lualine_z = {
          {
            "location",
            icon = { "", align = "right" },
          },
        },
      },
    },
  },
}
