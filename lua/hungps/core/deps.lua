local deps_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.deps"
if not vim.uv.fs_stat(deps_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.deps", deps_path })
  vim.cmd("packadd mini.deps | helptags ALL")
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require("mini.deps").setup()

--- @class MiniDepsSpec.hooks_args
--- @field path string
--- @field source string
--- @field name string
---
--- @class MiniDepsSpec.hooks
--- @field pre_install? fun(args?: MiniDepsSpec.hooks_args)
--- @field post_install? fun(args?: MiniDepsSpec.hooks_args)
--- @field pre_checkout? fun(args?: MiniDepsSpec.hooks_args)
--- @field post_checkout? fun(args?: MiniDepsSpec.hooks_args)

--- @class MiniDepsSpec
--- @field source string
--- @field name? string
--- @field checkout? string
--- @field monitor? string
--- @field depends? table
--- @field hooks? MiniDepsSpec.hooks

--- @param specs string|string[]|MiniDepsSpec|MiniDepsSpec[] Plugin specification. Multiple specs are allowed. See |MiniDeps-plugin-specification|.
--- @param callback function
_G.add = function(specs, callback)
  if type(specs) == "string" or specs.source then specs = { specs } end

  for _, spec in ipairs(specs) do
    MiniDeps.add(spec)
  end

  callback()
end
