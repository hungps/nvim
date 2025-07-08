local get_flutter_home_path = function()
  if vim.uv.fs_stat(vim.uv.cwd() .. "/.fvm/flutter_sdk") then
    return vim.uv.cwd() .. "/.fvm/flutter_sdk"
  end

  return os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_HOME")
end

local get_dart_path = function()
  return get_flutter_home_path() .. "/bin/dart"
end

local get_flutter_path = function()
  return get_flutter_home_path() .. "/bin/flutter"
end

local shell = require("overseer.shell")
local M = {}

---@param defn table This is the decoded JSON data for the task
---@return table
M.get_task_opts = function(defn)
  local cmd = { defn.command }

  if defn.command == "dart" then
    cmd = { get_dart_path() }
  end

  if defn.command == "flutter" then
    cmd = { get_flutter_path() }
  end

  if defn.args and not vim.tbl_isempty(defn.args) then
    cmd = { shell.escape_cmd(vim.list_extend(cmd, defn.args)) }
  end

  return {
    cmd = cmd,
  }
end

M.problem_matchers = {
  ["$dart-build_runner"] = {
    fileLocation = { "relative", "${cwd}" },
    pattern = {
      {
        regexp = "^\\[SEVERE\\] .+ on (.{-1,}).+$",
        file = 1,
      },
      {
        regexp = "^$",
      },
      {
        regexp = "^(.+)$",
        message = 1,
      },
      {
        regexp = "^package:.*:(\\d+):(\\d+)$",
        line = 1,
        column = 2,
      },
    },
    background = {
      activeOnStart = true,
      beginsPattern = "^\\[INFO\\] Starting Build",
      endsPattern = "^(\\[INFO\\] Succeeded|\\[SEVERE\\] Failed) after",
    },
  },
}

return M
