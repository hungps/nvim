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

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
          local config = vim.api.nvim_win_get_config(args.data.win_id)

          table.insert(config.title, { " ", "MiniFilesTitle" })
          table.insert(config.title, 1, { " ", "MiniFilesTitle" })

          vim.api.nvim_win_set_config(args.data.win_id, config)
        end,
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = {
      { "junegunn/fzf", build = "./install --bin" },
    },
    keys = {
      {
        "<leader>bb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "List [B]uffer",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find [F]ile",
      },
      {
        "<leader>fo",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "Find [O]ld files",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").resume()
        end,
        desc = "[R]esume find",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").lgrep_curbuf()
        end,
        desc = "Find in [B]uffer",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Find by [G]rep",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").grep_visual()
        end,
        desc = "Find by [G]rep selected text",
        mode = "v",
      },
      {
        "<leader>gfc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Find [C]ommit",
        mode = "v",
      },
      {
        "<leader>fc",
        function()
          require("fzf-lua").commands()
        end,
        desc = "Find [C]ommand",
      },
      {
        "<leader>fh",
        function()
          require("fzf-lua").highlights()
        end,
        desc = "Find [H]ighlight group",
      },
      {
        "<leader>fs",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Find Document [S]ymbol",
      },
      {
        "<leader>fS",
        function()
          require("fzf-lua").lsp_workspace_symbols()
        end,
        desc = "Find workspace [S]ymbol",
      },
      {
        "<leader>g",
        desc = "[G]oto",
      },
    },
    opts = {
      file_icon_padding = " ",
      file_ignore_patterns = { ".git", ".DS_Store" },
      files = {
        git_icons = false,
        cwd_prompt = false,
        prompt = "Files❯ ",
        formatter = "path.filename_first",
      },
      oldfiles = {
        include_current_session = true,
      },
      grep = {
        git_icons = false,
        async = true,
        formatter = "path.filename_first",
        rg_glob = true,
        glob_flag = "--iglob",
        glob_separator = "%s%-%-",
      },
      lsp = {
        includeDeclaration = false,
        async = false,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100,
        },
      },
      winopts = {
        preview = {
          vertical = "down:60%",
          layout = "vertical",
        },
      },
      keymap = {
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
          ["<C-q>"] = "select-all+accept",
        },
        fzf = {
          true,
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-a"] = "toggle-all",
          ["ctrl-q"] = "select-all+accept",
        },
      },
    },
    config = function(_, opts)
      local fzf = require("fzf-lua")

      fzf.setup(opts)

      -- Use fzf as vim.ui.select
      fzf.register_ui_select(function(_, items)
        -- Calculate the size of the window based on the number of items
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end

        return {
          winopts = {
            height = h,
            width = 0.70,
            row = 0.40,
            preview = {
              horizontal = "right:40%",
              layout = "horizontal",
            },
          },
        }
      end)

      vim.api.nvim_create_autocmd("VimResized", {
        pattern = "*",
        callback = fzf.redraw,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("FzfLuaLsp", { clear = true }),
        callback = function(event)
          vim.keymap.set("n", "gd", function()
            require("fzf-lua").lsp_definitions({
              sync = true,
              jump_to_single_result = true,
            })
          end, { buffer = event.buf, desc = "[G]oto: [D]efinition", noremap = true })

          vim.keymap.set("n", "gr", function()
            require("fzf-lua").lsp_references({ cwd_only = true })
          end, { buffer = event.buf, desc = "[G]oto: Project [R]eferences", noremap = true })

          vim.keymap.set("n", "gR", function()
            require("fzf-lua").lsp_references()
          end, { buffer = event.buf, desc = "[G]oto: All [R]eferences", noremap = true })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fzf",
        callback = function(event)
          vim.keymap.set("t", "<Esc>", "<C-c>", { buffer = event.buf, noremap = true })
        end,
      })
    end,
  },
}
