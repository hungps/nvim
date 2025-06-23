local pascal_to_snake = function(str)
  local snake = str:gsub("(%u)", function(c) return "_" .. c:lower() end)
  snake = snake:gsub("^_", "")
  return snake
end

return {
  s(
    "cubitselectorbase",
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
        cubit_name_snake_case = f(function(args) return pascal_to_snake(args[1][1]) end, { 1 }),
        cubit_name_rep = rep(1),
        fin = i(0),
      }
    )
  ),
  s(
    "cubitselector",
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
        type = i(3, f(function(args) return args[1][1] .. args[2][1] end, { 1, 2 })),
        selector = c(4, {
          t("state.status"),
          { t("state."), i(nil) },
          i(nil),
        }),
        fin = i(0),
      }
    )
  ),
}
