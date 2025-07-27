return {
  {
    "echasnovski/mini.files",
    event = "VeryLazy",
    keys = {
      {
        "<leader>fe",
        function()
          local buffer = vim.api.nvim_buf_get_name(0)
          if vim.startswith(buffer, "/") then
            require("mini.files").open(buffer)
          else
            require("mini.files").open(vim.uv.cwd())
          end
        end,
        desc = "File Explorer",
      },
      {
        "<leader>fE",
        function() require("mini.files").open(vim.uv.cwd()) end,
        desc = "File Explorer (root)",
      },
    },
    opts = {
      content = {
        hidden_file_patterns = {
          "^%.git$",
          "^%.DS_Store$",
        },
      },
      options = {
        permanent_delete = false,
      },
      windows = {
        preview = true,
        width_preview = 60,
      },
    },
    config = function(_, opts)
      local files = require("mini.files")

      local show_hidden_files = false

      opts.content.filter = function(fs_entry)
        if show_hidden_files then return true end

        for _, pattern in ipairs(opts.content.hidden_file_patterns) do
          if fs_entry.name:match(pattern) then return false end
        end

        return true
      end

      files.setup(opts)

      local toggle_hidden_files = function()
        show_hidden_files = not show_hidden_files
        files.refresh(opts)
      end

      local open_trash = function() files.open(vim.fn.stdpath("data") .. "/mini.files/trash") end

      local get_fs_entry_path = function() return (files.get_fs_entry() or {}).path end

      local set_cwd = function() vim.fn.chdir(vim.fs.dirname(get_fs_entry_path())) end

      local yank_path = function() vim.fn.setreg(vim.v.register, get_fs_entry_path()) end

      local open_in_system = function() vim.ui.open(get_fs_entry_path()) end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local bufnr = args.data.buf_id

          vim.keymap.set("n", "g.", toggle_hidden_files, { buffer = bufnr, desc = "Toggle hidden files" })
          vim.keymap.set("n", "g~", set_cwd, { buffer = bufnr, desc = "Set as root directory" })
          vim.keymap.set("n", "gy", yank_path, { buffer = bufnr, desc = "Yank path" })
          vim.keymap.set("n", "go", open_in_system, { buffer = bufnr, desc = "Open in System" })
          vim.keymap.set("n", "gt", open_trash, { buffer = bufnr, desc = "Open trash bin" })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesExplorerOpen",
        callback = function()
          files.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
          files.set_bookmark("s", vim.fn.stdpath("config") .. "/lua/hungps/snippets", { desc = "Snippets" })
          files.set_bookmark("w", vim.fn.getcwd, { desc = "Working dir" })
          files.set_bookmark("~", "~", { desc = "Home" })
          files.set_bookmark(".", "~/.dotfiles", { desc = "Dotfiles" })
        end,
      })
    end,
  },
}
