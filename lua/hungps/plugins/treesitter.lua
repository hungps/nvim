add({
  {
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
  },
  {
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    checkout = "main",
  },
}, function()
  local parsers = Config.treesitter_parsers
  local filetypes = vim.iter(parsers):map(vim.treesitter.language.get_filetypes):flatten():totable()

  require("nvim-treesitter").install(parsers)

  autocmd("Enable treesitter", augroup("Treesitter"), "FileType", filetypes, function(ev)
    vim.treesitter.start(ev.buf)

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- -- https://www.reddit.com/r/neovim/comments/14n6iiy/if_you_have_treesitter_make_sure_to_disable/
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- vim.opt.smartindent = false
  end)
end)
