local M = {}

M.flutter_home_path = function()
  if vim.uv.fs_stat(vim.uv.cwd() .. "/.fvm/flutter-sdk") then return vim.uv.cwd() .. "/.fvm/flutter-sdk" end

  return os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_HOME")
end

M.dart_path = function() return M.flutter_home_path() .. "/bin/dart" end

M.flutter_path = function() return M.flutter_home_path() .. "/bin/flutter" end

return M
