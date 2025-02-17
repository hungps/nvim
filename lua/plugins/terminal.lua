return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<leader>tt",
        "<Cmd>ToggleTerm<CR>",
        desc = "[T]erminal",
      },
    },
    opts = {
      open_mapping = [[\]],
      insert_mappings = false,
      terminal_mappings = false,
      shade_terminals = false,
      persist_mode = false,
      persist_size = false,
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.api.nvim_create_autocmd("TermOpen", {
        group = vim.api.nvim_create_augroup("ToggleTermOpen", { clear = false }),
        pattern = "term://*",
        callback = function(event)
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = event.buf })
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = event.buf })
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = event.buf })
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = event.buf })
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = event.buf })
        end,
      })
    end,
  },
}
