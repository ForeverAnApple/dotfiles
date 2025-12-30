local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          extraEnv = { SQLX_OFFLINE = "true" },
        },
      },
    },
  },
}
