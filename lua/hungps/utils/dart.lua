local M = {}

M.get_flutter_home_path = function()
  if vim.uv.fs_stat(vim.uv.cwd() .. "/.fvm/flutter-sdk") then return vim.uv.cwd() .. "/.fvm/flutter-sdk" end

  return os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_HOME")
end

M.get_dart_path = function() return M.flutter_home_path() .. "/bin/dart" end

M.get_flutter_path = function() return M.flutter_home_path() .. "/bin/flutter" end

M.line_length_sources = {
  analysis_options = { path = "analysis_options.yaml", pattern = "page_width: (%d-)" },
  vscode = { path = ".vscode/settings.json", pattern = '"dart.lineLength": (%d-),' },
  editorconfig = { path = ".editorconfig", pattern = "%[%*%.dart%].-max_line_length%s-=%s-(%d-)[\n%[$]" },
}

M.get_line_length = function()
  local file_utils = require("hungps.utils.file")
  local cwd = vim.fn.getcwd() .. "/"

  for type, source in pairs(M.line_length_sources) do
    local match = file_utils.match(cwd .. source.path, source.pattern)

    if match then
      print("Using line length " .. match .. " from " .. type)

      return tonumber(match)
    end
  end
end

return M
