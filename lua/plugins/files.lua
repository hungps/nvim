return {
  {
    "echasnovski/mini.files",
    event = "VeryLazy",
    keys = {
      {
        "<leader>fe",
        function()
          local buffer = vim.api.nvim_buf_get_name(0)
          if vim.fn.expand("%:p") == "" then
            require("mini.files").open(vim.uv.cwd())
          else
            require("mini.files").open(buffer)
          end
        end,
        desc = "File [E]xplorer",
      },
    },
    opts = {
      content = {
        always_hidden_suffix = {
          ".git",
          ".DS_Store",
        },
        hidden_file_suffix = {},
      },
      options = {
        permanent_delete = true,
      },
      windows = {
        preview = true,
        width_preview = 60,
      },
    },
    config = function(_, opts)
      vim.g.minifiles_enable_filter = true

      opts.content.filter = function(fs_entry)
        for _, suffix in pairs(opts.content.always_hidden_suffix) do
          if fs_entry.name == suffix or vim.endswith(fs_entry.name, suffix) then
            return false
          end
        end

        if not vim.g.minifiles_enable_filter then
          return true
        end

        for _, suffix in pairs(opts.content.hidden_file_suffix) do
          if fs_entry.name == suffix or vim.endswith(fs_entry.name, suffix) then
            return false
          end
        end

        return true
      end

      require("mini.files").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          -- Toggle show/hide dotfiles
          vim.keymap.set("n", "g.", function()
            vim.g.minifiles_enable_filter = not vim.g.minifiles_enable_filter
            require("mini.files").refresh(opts)
          end, { buffer = args.data.buf_id, desc = "Toggle dotfiles" })

          -- Set the hovering folder as current directory
          vim.keymap.set("n", "g~", function()
            local cur_entry_path = require("mini.files").get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
          end, { buffer = args.data.buf_id, desc = "Set as root directory" })
        end,
      })
    end,
  },
  {
    "echasnovski/mini.pick",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.extra",
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("mini.pick").builtin.files()
        end,
        desc = "Find [F]ile",
      },
      {
        "<leader>fr",
        function()
          require("mini.pick").builtin.resume()
        end,
        desc = "[R]esume find",
      },
      {
        "<leader>fg",
        function()
          require("mini.pick").builtin.grep_live()
        end,
        desc = "Find by [G]rep",
      },
      {
        "<leader>fb",
        function()
          require("mini.extra").pickers.buf_lines()
        end,
        desc = "Find in [B]uffer",
      },
      {
        "<leader>fc",
        function()
          require("mini.extra").pickers.commands()
        end,
        desc = "Find [C]ommand",
      },
      {
        "<leader>fh",
        function()
          require("mini.extra").pickers.hl_groups()
        end,
        desc = "Find [H]ighlight group",
      },
      {
        "<leader>fs",
        function()
          require("mini.extra").pickers.lsp({ scope = "document_symbol" })
        end,
        desc = "Find Document [S]ymbol",
      },
      {
        "<leader>fS",
        function()
          require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
        end,
        desc = "Find workspace [S]ymbol",
      },
      {
        "<leader>fm",
        function()
          require("mini.extra").pickers.marks({ scope = "buf" })
        end,
        desc = "Find buffer [M]ark",
      },
      {
        "<leader>fm",
        function()
          require("mini.extra").pickers.marks({ scope = "global" })
        end,
        desc = "Find workspace [M]ark",
      },
      {
        "<leader>fo",
        function()
          require("mini.extra").pickers.oldfiles()
        end,
        desc = "Find [O]ld (recent) files",
      },
      {
        "<leader>ft",
        function()
          require("mini.extra").pickers.treesitter()
        end,
        desc = "Find [T]reesitter note",
      },
    },
    opts = {},
  },
}
