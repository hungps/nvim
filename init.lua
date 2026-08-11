require("vim._core.ui2").enable({
  enable = true,
  msg = {
    target = "msg"
  }
})

local add = function(specs)
  specs = vim
      .iter(specs)
      :map(function(s)
        local spec = type(s) == "string" and { src = s } or s

        if not spec.src:match("^https?") and not spec.src:match("^/") then
          spec.src = "https://github.com/" .. spec.src
        end

        return spec
      end)
      :totable()

  vim.pack.add(specs)
end

add({
  { src = "nvim-lua/plenary.nvim",                       branch = "master" },
  -- Colorschemes
  { src = "AlexvZyl/nordic.nvim" },
  -- Treesitter
  { src = "nvim-treesitter/nvim-treesitter",             version = "main" },
  { src = "nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  -- Cmp
  { src = "saghen/blink.cmp",                            version = "v1.8.0" },
  -- Mini
  { src = "echasnovski/mini.nvim" },
  -- AI
  { src = "zbirenbaum/copilot.lua" },
  -- Coding
  { src = "neovim/nvim-lspconfig" },
  { src = "stevearc/conform.nvim" },
  { src = "mfussenegger/nvim-lint" },
  -- Dap
  { src = "mfussenegger/nvim-dap" },
  { src = "igorlfs/nvim-dap-view" },
  -- Diagnostic
  { src = "folke/trouble.nvim" },
  -- Git
  { src = "tpope/vim-fugitive" },
  { src = "lewis6991/gitsigns.nvim" },
  -- ft
  { src = "folke/lazydev.nvim" },
  { src = "nvim-flutter/flutter-tools.nvim" },
  { src = "MeanderingProgrammer/render-markdown.nvim" },
  -- util
  { src = "j-hui/fidget.nvim" },
})
