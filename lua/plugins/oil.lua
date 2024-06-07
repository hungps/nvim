return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      experimental_watch_for_changes = true,
      view_options = {
        show_hidden = false,
        hidden_file_suffix = {
          ".DS_Store",
          ".git",
          ".idea",
          ".vscode",
          ".gradle",
          ".lock",
          ".ruby-lsp",
          "build",
        },
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-t>"] = false,
        ["gs"] = false,
        ["gx"] = false,
      },
    },
    config = function(_, opts)
      opts.view_options.is_hidden_file = function(name, _)
        for _, suffix in pairs(opts.view_options.hidden_file_suffix) do
          if name == suffix or vim.endswith(name, suffix) then
            return true
          end
        end

        return false
      end

      require("oil").setup(opts)
    end,
  },
}
