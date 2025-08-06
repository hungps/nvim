add("mason-org/mason.nvim", function() require("mason").setup() end)

add({
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  "mason-org/mason-lspconfig.nvim",
}, function()
  local all_masonlsp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
  local lsp_servers = vim
    .iter(vim.tbl_keys(Config.lsp_servers))
    :filter(function(server) return vim.list_contains(all_masonlsp_servers, server) end)
    :totable()

  local packages = vim
    .iter({
      lsp_servers,
      vim.tbl_values(Config.linters_by_ft),
      vim.tbl_values(Config.formatters_by_ft),
      vim.tbl_values(Config.debuggers_by_ft),
      Config.compilers,
    })
    :flatten(math.huge)
    :totable()

  require("mason-tool-installer").setup({ ensure_installed = packages })
end)
