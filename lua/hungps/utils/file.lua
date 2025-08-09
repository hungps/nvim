local M = {}

--- Reads the file and returns its content
--- Returns nil if the file does not exist or cannot be read
--- @param path string
--- @return string?
M.read_file = function(path)
  if not vim.loop.fs_stat(path) then return end

  local file = io.open(path, "r")
  if not file then return end

  local content = file:read("*a")
  file:close()

  return content
end

--- Reads the file and returns the first match of the pattern in its content.
--- Returns nil if the file does not exist, cannot be read, or no match is found.
--- @param path string
--- @param pattern string
--- @return string?
M.match = function(path, pattern)
  local content = M.read_file(path)
  if not content then return end

  return content:match(pattern)
end

return M
