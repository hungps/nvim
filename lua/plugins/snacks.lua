return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>bd",
        function() require("snacks").bufdelete.delete() end,
        desc = "Close current buffer",
      },
      {
        "<leader>bo",
        function() require("snacks").bufdelete.other() end,
        desc = "Close other buffer",
      },
      {
        "<leader>ts",
        function() require("snacks").scratch() end,
        desc = "Open scratch buffer",
      },
      {
        "<leader>tt",
        function() require("snacks").terminal.toggle() end,
        desc = "Toggle terminal",
      },
      {
        "<leader>go",
        function() require("snacks").gitbrowse.open() end,
        desc = "Open in browser",
      },
      {
        "<leader>tn",
        function() require("snacks").notifier.show_history() end,
        desc = "Notification history",
      },
      {
        "<leader>ff",
        function() require("snacks").picker.files() end,
        desc = "Find File",
      },
      {
        "<leader>fo",
        function() require("snacks").picker.recent() end,
        desc = "Find Old files",
      },
      {
        "<leader>fr",
        function() require("snacks").picker.resume() end,
        desc = "Resume last find",
      },
      {
        "<leader>fg",
        function() require("snacks").picker.grep() end,
        desc = "Find by Grep",
      },
      {
        "<leader>fg",
        function() require("snacks").picker.grep_word() end,
        desc = "Find by Grep selected text",
        mode = { "x", "v" },
      },
      {
        "<leader>fc",
        function() require("snacks").picker.commands() end,
        desc = "Find Command",
      },
      {
        "<leader>fh",
        function() require("snacks").picker.highlights() end,
        desc = "Find Highlight group",
      },
      {
        "<leader>fs",
        function() require("snacks").picker.lsp_symbols() end,
        desc = "Find Document Symbol",
      },
      {
        "<leader>fS",
        function() require("snacks").picker.lsp_workspace_symbols() end,
        desc = "Find workspace Symbol",
      },
      {
        "<leader>tz",
        function() require("snacks").zen.zen() end,
        desc = "Toggle [Z]en mode",
      },
    },
    opts = {
      bigfile = {},
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      dim = {
        animate = {
          enabled = false,
        },
      },
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
      input = {},
      notifier = {},
      picker = {
        formatters = {
          file = {
            filename_first = true,
            truncate = 60,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
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
      toggle = {},
      words = {},
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
