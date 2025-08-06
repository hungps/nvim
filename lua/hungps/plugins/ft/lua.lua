add(
  "folke/lazydev.nvim",
  function()
    require("lazydev").setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv", "vim%.loop" } },
      },
    })
  end
)
