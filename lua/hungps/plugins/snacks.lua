return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>bd", function() require("snacks").bufdelete.delete() end, desc = "Close current buffer" },
      { "<leader>bo", function() require("snacks").bufdelete.other() end, desc = "Close other buffer" },
      { "<leader>ts", function() require("snacks").scratch() end, desc = "Open scratch buffer" },
      { "<leader>tt", function() require("snacks").terminal.toggle() end, desc = "Toggle terminal" },
      { "<leader>go", function() require("snacks").gitbrowse.open() end, desc = "Open in browser" },
      { "<leader>tz", function() require("snacks").zen.zen() end, desc = "Toggle [Z]en mode" },
    },
    opts = {
      bigfile = {},
      image = {},
      indent = {
        indent = {
          only_scope = true,
          only_current = true,
        },
        animate = {
          enabled = false,
        },
      },
      quickfile = {},
      rename = {},
      scope = {
        cursor = false,
      },
      statuscolumn = {
        folds = {
          open = false,
          git_hl = true,
        },
      },
      terminal = {},
      zen = {},
      styles = {
        input = {
          relative = "cursor",
          row = -3,
          col = -1,
        },
      },
    },
    init = function()
      _G.dd = function(...) require("snacks").debug.inspect(...) end
      _G.bt = function() require("snacks").debug.backtrace() end
      vim.print = _G.dd
    end,
    config = function(_, opts)
      require("snacks").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event) require("snacks").rename.on_rename_file(event.data.from, event.data.to) end,
      })
    end,
  },
}
