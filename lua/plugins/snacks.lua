return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>bd",
        function()
          require("snacks").bufdelete.delete()
        end,
        desc = "Close [C]urrent Buffer",
      },
      {
        "<leader>bo",
        function()
          require("snacks").bufdelete.other()
        end,
        desc = "Close [O]ther Buffer",
      },
      {
        "<leader>ts",
        function()
          require("snacks").scratch()
        end,
        desc = "Open scratch buffer",
      },
      {
        "<leader>tt",
        function()
          require("snacks").terminal.toggle()
        end,
        desc = "Toggle terminal",
      },
      {
        "<leader>go",
        function()
          require("snacks").gitbrowse.open()
        end,
        desc = "[O]pen in browser",
      },
      {
        "<leader>tn",
        function()
          require("snacks").notifier.show_history()
        end,
        desc = "[N]otification history",
      },
      {
        "<leader>ff",
        function()
          require("snacks").picker.files()
        end,
        desc = "Find [F]ile",
      },
      {
        "<leader>fo",
        function()
          require("snacks").picker.recent()
        end,
        desc = "Find [O]ld files",
      },
      {
        "<leader>fr",
        function()
          require("snacks").picker.resume()
        end,
        desc = "[R]esume last find",
      },
      {
        "<leader>fg",
        function()
          require("snacks").picker.grep()
        end,
        desc = "Find by [G]rep",
      },
      {
        "<leader>fg",
        function()
          require("snacks").picker.grep_word()
        end,
        desc = "Find by [G]rep selected text",
        mode = { "x", "v" },
      },
      {
        "<leader>fc",
        function()
          require("snacks").picker.commands()
        end,
        desc = "Find [C]ommand",
      },
      {
        "<leader>fh",
        function()
          require("snacks").picker.highlights()
        end,
        desc = "Find [H]ighlight group",
      },
      {
        "<leader>fs",
        function()
          require("snacks").picker.lsp_symbols()
        end,
        desc = "Find Document [S]ymbol",
      },
      {
        "<leader>fS",
        function()
          require("snacks").picker.lsp_workspace_symbols()
        end,
        desc = "Find workspace [S]ymbol",
      },
      {
        "<leader>tz",
        function()
          require("snacks").zen.zen()
        end,
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
      -- scroll = {
      --   animate = {
      --     duration = { step = 10, total = 100 },
      --     easing = "linear",
      --   },
      -- },
      statuscolumn = {
        left = { "git", "sign" },
        right = { "fold", "mark" },
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
      _G.dd = function(...)
        require("snacks").debug.inspect(...)
      end
      _G.bt = function()
        require("snacks").debug.backtrace()
      end
      vim.print = _G.dd
    end,
    config = function(_, opts)
      require("snacks").setup(opts)

      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("SnacksCustomLsp", { clear = true }),
      --   callback = function(event)
      --     vim.keymap.set("n", "gd", function()
      --       require("snacks").picker.lsp_definitions()
      --     end, { buffer = event.buf, desc = "[G]oto: [D]efinition", noremap = true })
      --
      --     vim.keymap.set("n", "gD", function()
      --       require("snacks").picker.lsp_declarations()
      --     end, { buffer = event.buf, desc = "[G]oto: [D]eclaration", noremap = true })
      --
      --     vim.keymap.set("n", "grr", function()
      --       require("snacks").picker.lsp_references()
      --     end, { buffer = event.buf, desc = "[G]oto: [R]eferences", noremap = true, nowait = true })
      --
      --     vim.keymap.set("n", "gi", function()
      --       require("snacks").picker.lsp_implementations()
      --     end, { buffer = event.buf, desc = "[G]oto: [I]mplementation", noremap = true })
      --
      --     vim.keymap.set("n", "gI", function()
      --       require("snacks").picker.lsp_type_definitions()
      --     end, { buffer = event.buf, desc = "[G]oto: Type [I]mplementation", noremap = true })
      --   end,
      -- })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("snacks").rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  },
}
