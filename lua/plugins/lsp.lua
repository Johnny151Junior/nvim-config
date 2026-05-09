pcall(function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("gopls", {
    capabilities = capabilities,
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
      },
    },
  })

  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
  })

  vim.lsp.config("clangd", {
    capabilities = capabilities,
  })

  vim.lsp.enable({
    "gopls",
    "ts_ls",
    "clangd",
  })
end)
