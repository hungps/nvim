return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "[P]in/Unpin buffer" },
      { "<leader>bd", desc = "[D]elete buffer(s)" },
      { "<leader>bdc", "<cmd>:bd<CR>", desc = "Delete [C]urrent buffer" },
      { "<leader>bdp", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-[P]inned Buffers" },
      { "<leader>bdo", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete [O]ther Buffers" },
      { "<leader>bdl", "<cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the [L]eft" },
      { "<leader>bdr", "<cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the [R]ight" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        -- indicator = {
        --   style = "none",
        -- },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        tab_size = 30,
      },
    },
  },
}
