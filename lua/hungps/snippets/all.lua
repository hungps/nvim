return {
  s("ternary", {
    i(1, "cond"),
    t(" ? "),
    i(2, "then"),
    t(" : "),
    i(3, "else"),
  }),
  s(
    "arrow",
    fmt([[({}) => {}{fin}]], {
      i(1),
      i(2),
      fin = i(0),
    })
  ),
  s(
    "anonfunc",
    fmt(
      [[
        ({}) {{
          {}
        }}{fin}
      ]],
      {
        i(1),
        i(2),
        fin = i(0),
      }
    )
  ),
}
