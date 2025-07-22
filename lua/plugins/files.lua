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
        hidden_file_suffix = {
          ".git",
          ".DS_Store",
        },
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
        if not vim.g.minifiles_enable_filter then return true end

        for _, suffix in pairs(opts.content.hidden_file_suffix) do
          if fs_entry.name == suffix or vim.endswith(fs_entry.name, suffix) then return false end
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
}
