local pascal_to_snake = function(str)
  local snake = str:gsub("(%u)", function(c) return "_" .. c:lower() end)
  snake = snake:gsub("^_", "")
  return snake
end

return {
  -- Basic
  s("list", fmt([[List<{}>]], { i(0) })),
  s("map", fmt([[Map<{}, {}>]], { i(1), i(0) })),
  s("future", fmt([[Future<{}>]], { i(0) })),
  s("state", fmt([[State<{}>]], { i(0) })),
  s("generic", fmt([[{}<{}>]], { i(1), i(0) })),
  s("record", fmt([[({{{}}})]], { i(0) })),
  s(
    "variable",
    fmt([[{variable_type}{type}{name}{initial_value};]], {
      variable_type = c(1, {
        t("final "),
        t("const "),
        t("late "),
        t("late final "),
        t(""),
      }),
      type = c(2, {
        i(nil, "String "),
        t(""),
      }),
      name = i(3, "someVariable"),
      initial_value = c(4, {
        sn(nil, { t(" = "), i(1, "SomeValue") }),
        t(""),
      }),
    })
  ),
  s(
    "getter",
    fmt([[{type} get {name} => {value};]], {
      type = i(1, "String"),
      name = i(2, "someVariable"),
      value = i(0),
    })
  ),
  s(
    "privategetter",
    fmt(
      [[
        {type} _{name}{value};
        {type_rep} get {name_rep} => _{name_rep};
      ]],
      {
        type = i(1, "String"),
        name = i(2, "someVariable"),
        value = c(3, {
          t(""),
          sn(nil, { t(" = "), i(1) }),
        }),
        type_rep = rep(1),
        name_rep = rep(2),
      }
    )
  ),
  s(
    "setState",
    fmt([[setState({})]], {
      c(1, {
        sn(
          nil,
          fmt(
            [[
              () => {}
            ]],
            { i(1) }
          )
        ),
        sn(
          nil,
          fmt(
            [[
              () {{
                {}
              }}
            ]],
            { i(1) }
          )
        ),
      }),
    })
  ),
  s(
    "jsonvalue",
    fmt("{json}[{quote}{key}{quote_rep}]", {
      json = i(1, "json"),
      quote = c(2, { t([["]]), t([[']]) }),
      quote_rep = rep(2),
      key = i(3),
    })
  ),

  -- Flutter
  s(
    "widget",
    fmt(
      [[
        {name}(
          {body}
        ){trailing}
      ]],
      {
        name = i(1, "SomeWidget"),
        trailing = c(2, {
          t(","),
          t(";"),
          t(""),
        }),
        body = c(3, {
          sn(nil, { t("child: "), i(1) }),
          sn(nil, { t("children: "), i(1) }),
          sn(nil, { t("slivers: "), i(1) }),
          sn(nil, { t("body: "), i(1) }),
          i(nil),
        }),
      }
    )
  ),
  s(
    "edgeinsets",
    fmt([[{}EdgeInsets.{}]], {
      c(1, {
        t("const "),
        t(""),
      }),
      c(2, {
        sn(
          nil,
          fmt([[{}symmetric({})]], {
            i(1),
            c(2, {
              sn(nil, { t("horizontal: "), i(1, "0") }),
              sn(nil, { t("vertical: "), i(1, "0") }),
            }),
          })
        ),
        sn(
          nil,
          fmt([[{}only({})]], {
            i(1),
            c(2, {
              sn(nil, { t("left: "), i(1, "0") }),
              sn(nil, { t("top: "), i(1, "0") }),
              sn(nil, { t("bottom: "), i(1, "0") }),
              sn(nil, { t("right: "), i(1, "0") }),
            }),
          })
        ),
        sn(
          nil,
          fmt([[{}fromLTRB({}, {}, {}, {})]], {
            i(1),
            i(2, "0"),
            i(3, "0"),
            i(4, "0"),
            i(5, "0"),
          })
        ),
      }),
    })
  ),
  s("sizedboxshrink", { t("const SizedBox.shrink()") }),
  s("testbox", { t("Container(color: Colors.red, width: 50, height: 50)") }),

  -- Cubit
  s(
    "cubitSelectorBase",
    fmt(
      [[
        import 'package:flutter/material.dart';
        import 'package:flutter_bloc/flutter_bloc.dart';

        import '{cubit_name_snake_case}_cubit.dart';
        import '{cubit_name_snake_case}_state.dart';

        abstract class {cubit_name}Selector<T>
        extends BlocSelector<{cubit_name_rep}Cubit, {cubit_name_rep}State, T> {{
          {cubit_name_rep}Selector({{
            super.key,
            required super.selector,
            required Widget Function(T data) builder,
          }}) : super(builder: (_, data) => builder(data));
        }}

        abstract class {cubit_name_rep}Listener extends BlocListener<{cubit_name_rep}Cubit, {cubit_name_rep}State> {{
          const {cubit_name_rep}Listener({{
            super.key,
            required super.listenWhen,
            required super.listener,
          }});
        }}
        {fin}
    ]],
      {
        cubit_name = i(1, "MyCubit"),
        cubit_name_rep = rep(1),
        cubit_name_snake_case = f(function(args) return pascal_to_snake(args[1][1]) end, { 1 }),
        fin = i(0),
      }
    )
  ),
  s(
    "cubitSelector",
    fmt(
      [[
        class {cubit_name}{name}Selector extends {cubit_name_rep}Selector<{type}> {{
          {cubit_name_rep}{name_rep}Selector({{
            super.key,
            required super.builder
          }}) : super(selector: (state) => {selector});
        }}
        {fin}
      ]],
      {
        cubit_name = i(1, "MyCubit"),
        cubit_name_rep = rep(1),
        name = i(2, "Status"),
        name_rep = rep(2),
        type = c(3, {
          d(nil, function(args) return sn(nil, i(1, args[1])) end, { 2 }),
          d(nil, function(args) return sn(nil, fmt("List<{}>", { i(1, args[1]) })) end, { 2 }),
          sn(nil, fmt("({{{}}})", { i(1) })),
        }),
        selector = c(4, {
          sn(nil, { t("state."), i(1) }),
          sn(nil, fmt("({})", { i(1) })),
          i(nil),
        }),
        fin = i(0),
      }
    )
  ),
  s(
    "cubitListener",
    fmt(
      [[
        class {cubit_name}{name}Listener extends {cubit_name_rep}Listener {{
          {cubit_name_rep}{name_rep}Listener({{super.key, required super.listener}})
          : super(listenWhen: (prev, curr) => {listener});
        }}
        {fin}
      ]],
      {
        cubit_name = i(1, "MyCubit"),
        cubit_name_rep = rep(1),
        name = i(2, "Status"),
        name_rep = rep(2),
        listener = c(3, {
          d(
            nil,
            function(args)
              return sn(
                nil,
                fmt("prev.status != curr.status && curr.status == {cubit_name}Status.{status}", {
                  cubit_name = args[1][1],
                  status = i(1, "success"),
                })
              )
            end,
            { 1 }
          ),
          sn(
            nil,
            fmt("prev.{field} != curr.{field_rep} && curr.{field_rep} == {value}", {
              field = i(1),
              field_rep = rep(1),
              value = i(2),
            })
          ),
          i(nil),
        }),
        fin = i(0),
      }
    )
  ),
  s(
    "switchCase",
    fmt(
      [[
        case {}:
          {}
      ]],
      {
        i(1, "value"),
        i(0),
      }
    )
  ),
  s(
    "switchCaseInline",
    fmt(
      [[
        {} => {},
      ]],
      {
        i(1, "value"),
        i(0),
      }
    )
  ),
  s(
    "if",
    fmt(
      [[
        if ({condition}) {body}
      ]],
      {
        condition = c(1, {
          i(nil, "condition"),
          sn(nil, fmt([[{} case {}]], { i(1), i(2) })),
        }),
        body = c(2, {
          sn(
            nil,
            fmt(
              [[
                {{
                  {}
                }}
              ]],
              { i(1) }
            )
          ),
          i(nil),
        }),
      }
    )
  ),
  s(
    "for",
    fmt(
      [[
        for ({operator}) {body}
      ]],
      {
        operator = c(1, {
          sn(
            nil,
            fmt([[{} in {}]], {
              i(1, "item"),
              i(2, "list"),
            })
          ),
          sn(
            nil,
            fmt([[i = {}, i {} {}, {}]], {
              i(1, "0"),
              c(2, { t("<"), t("<="), t(">"), t(">=") }),
              i(3, "length"),
              i(4, "i++"),
            })
          ),
        }),
        body = c(2, {
          sn(
            nil,
            fmt(
              [[
                {{
                  {}
                }}
              ]],
              { i(1) }
            )
          ),
          i(nil),
        }),
      }
    )
  ),
  s(
    "switch",
    fmt(
      [[
        switch ({value}) {{
          {body}
        }}
      ]],
      {
        value = i(1),
        body = i(0),
      }
    )
  ),
  s(
    "class",
    fmt(
      [[
        {modifier} {name}{inh} {{
          {body}
        }}
      ]],
      {
        modifier = c(1, {
          t("class"),
          t("final class"),
          t("sealed class"),
          t("abstract class"),
          t("abstract interface class"),
        }),
        name = i(2, "SomeClass"),
        inh = i(3),
        body = i(0),
      }
    )
  ),
  s("extends", fmt([[extends {}]], { i(0) })),
  s("implements", fmt([[implements {}]], { i(0) })),
  s("with", fmt([[with {}]], { i(0) })),
  s(
    "constructor",
    fmt([[{const}{name}({parameters}){post};]], {
      const = c(1, {
        t("const "),
        t(""),
      }),
      name = i(2, "SomeClass"),
      parameters = c(3, {
        sn(
          nil,
          fmt(
            [[
              {{
                {}
              }}
            ]],
            { i(1) }
          )
        ),
        i(nil),
      }),
      post = c(4, {
        sn(nil, fmt([[: super({})]], { i(1) })),
        sn(nil, fmt([[: {}]], { i(1) })),
        i(nil),
      }),
    })
  ),
  s(
    "factory",
    fmt(
      [[
        factory {name}({parameters}) {{
          {body}
        }}
      ]],
      {
        name = i(1, "SomeClass.factoryName"),
        parameters = c(2, {
          sn(
            nil,
            fmt(
              [[
              {{
                {}
              }}
            ]],
              { i(1) }
            )
          ),
          i(nil),
        }),
        body = i(0),
      }
    )
  ),
  s(
    "required",
    fmt([[required {from}{name}{value},]], {
      from = c(1, {
        t("super."),
        t("this."),
        sn(nil, { i(1, "String"), t(" ") }),
      }),
      name = i(2, "someVariable"),
      value = c(3, {
        sn(nil, { t(" = "), i(1, "value") }),
        sn(nil, { t(" = const "), i(1, "value") }),
        i(nil),
      }),
    })
  ),
  s(
    "func",
    fmt(
      [[
        {type} {name}({args}){func_type} {{
          {body}
        }}
      ]],
      {
        type = i(1, "void"),
        name = i(2, "functionName"),
        args = i(3, "args"),
        func_type = c(4, {
          i(nil),
          t(" async"),
          t(" sync*"),
        }),
        body = i(0),
      }
    )
  ),
}, {}
