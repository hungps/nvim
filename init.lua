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
  { src = "nvim-lua/plenary.nvim", branch = "master" },
  -- Colorschemes
  { src = "AlexvZyl/nordic.nvim" },
  -- Cmp
  { src = "saghen/blink.cmp", version = "v1.8.0" },
  -- Mini
  { src = "echasnovski/mini.nvim" },
  -- Coding
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
  { src = "akinsho/flutter-tools.nvim" },
  { src = "MeanderingProgrammer/render-markdown.nvim" },
  -- util
  { src = "noir4y/comment-translate.nvim" },
  { src = "j-hui/fidget.nvim" },
})
