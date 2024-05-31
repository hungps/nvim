return {
  -- formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    -- stylua: ignore
    keys = {
      { "<leader>cf", function() require("conform").format { lsp_fallback = true } end, desc = "[F]ormat" },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {},
    },
    config = function()
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  -- toggle comments
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },
  -- search and repalce multiple files
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      open_cmd = "noswapfile vnew",
    },
    keys = {
      -- stylua: ignore start
      { "<leader>sr", "<cmd>Spectre open<CR>", desc = "Search and [R]eplace" },
    },
  },
  -- multi cursors
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_default_mappings = 0
    end,
  },
  -- auto closing quotes, brackets, etc
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  -- Add quote/parenthesis/brackets around selected text
  {
    "echasnovski/mini.surround",
    event = "InsertEnter",
    version = "*",
    opts = {},
  },
  -- Better around/inside
  {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    version = "*",
    opts = {},
  },
}
