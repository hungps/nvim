add(
  "echasnovski/mini.sessions",
  function()
    require("mini.sessions").setup({
      autoread = true,
      autowrite = true,
    })
  end
)
