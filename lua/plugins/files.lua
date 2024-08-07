return {
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>fe",
        function()
          local buffer_name = vim.api.nvim_buf_get_name(0)
          if buffer_name == "" or string.match(buffer_name, "Starter") then
            require("mini.files").open(vim.uv.cwd())
          else
            require("mini.files").open(buffer_name)
          end
        end,
        desc = "File [E]xplorer",
      },
    },
    opts = {
      content = {
        hidden_file_suffix = {
          ".git",
          ".DS_Store",
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
      vim.g.minifiles_enable_filter = true

      opts.content.filter = function(fs_entry)
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

      -- Toggle show/hide dotfiles
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "g.", function()
            vim.g.minifiles_enable_filter = not vim.g.minifiles_enable_filter
            require("mini.files").refresh(opts)
          end, { buffer = args.data.buf_id })
        end,
      })

      -- Set the hovering folder as current directory
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "g~", function()
            local cur_entry_path = MiniFiles.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
          end, { buffer = args.data.buf_id })
        end,
      })
    end,
  },
  {
    "echasnovski/mini.pick",
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
    },
    opts = {
      options = {
        use_cache = true,
      },
    },
  },
}
