return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        width = 30,
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          show_hidden_count = true,
          hide_by_name = {
            ".gitkeep",
            "build",
          },
          hide_by_pattern = {
            "*-lock.json",
          },
          never_show = {
            ".git",
            ".svn",
            ".DS_Store",
          },
        },
        window = {
          mappings = {
            ["<space>"] = "none",
            ["\\"] = "close_window",
            ["Y"] = {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.setreg("+", path, "c")
              end,
              desc = "Copy Path to Clipboard",
            },
            ["O"] = {
              function(state)
                require("lazy.util").open(state.tree:get_node().path, { system = true })
              end,
              desc = "Open with System Application",
            },
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      -- Set `keys=` causing netrw to be show when opening vim with "vim .", so we use vim.keymap.set instead
      vim.keymap.set("n", "\\", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })
    end,
  },
}
