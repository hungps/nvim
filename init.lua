if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Neovim 0.12+ required", vim.log.levels.ERROR)
  return
end

vim.g._ts_force_sync_parsing = true
require("vim._extui").enable({})

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
  { src = "nvim-lua/plenary.nvim" },
  -- Colorschemes
  { src = "catppuccin/nvim", name = "catppuccin" },
  { src = "AlexvZyl/nordic.nvim" },
  -- Tmux
  { src = "christoomey/vim-tmux-navigator" },
  -- Treesitter
  { src = "nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  -- Cmp
  { src = "L3MON4D3/LuaSnip", version = "v2.4.0" },
  { src = "saghen/blink.cmp", version = "v1.6.0" },
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
  -- UI
  { src = "j-hui/fidget.nvim" },
  -- AI
  { src = "zbirenbaum/copilot.lua" },
  { src = "olimorris/codecompanion.nvim" },
  -- ft
  { src = "folke/lazydev.nvim" },
  { src = "akinsho/flutter-tools.nvim" },
  { src = "MeanderingProgrammer/render-markdown.nvim" },
  -- misc
  { src = "zk-org/zk-nvim" },
  { src = "bngarren/checkmate.nvim" },
})
