return {
  s(
    "local",
    fmt([[local {name} = {value}]], {
      name = i(1, "someVariable"),
      value = i(2, "SomeValue"),
    })
  ),
  s(
    "if",
    fmt(
      [[
        if {condition} then
          {body}
        end
      ]],
      {
        condition = i(1),
        body = i(0),
      }
    )
  ),
  s(
    "for",
    fmt(
      [[
        for {operator} do
          {body}
        end
      ]],
      {
        operator = c(1, {
          sn(nil, fmt([[{} in ipair({})]], { i(1, "k, v"), i(2, "list") })),
          sn(nil, fmt([[{} in pair({})]], { i(1, "i, v"), i(2, "list") })),
          i(nil),
        }),
        body = i(0),
      }
    )
  ),
  s(
    "func",
    fmt(
      [[function({args}){body}end]],
      {
        args = i(1),
        body = c(2, {
          sn(nil, { t(' '), i(1), t(' ') }),
          sn(nil, { t({ '', '\t' }), i(1), t({ '', '' }) }),
        }),
      }
    )
  ),
}, {}
