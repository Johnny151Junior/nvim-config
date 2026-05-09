pcall(function()
  require("conform").setup({
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },

      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },

      c = { "clang_format" },
      cpp = { "clang_format" },

      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      markdown = { "prettier" },
    },
  })
end)
