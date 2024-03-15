local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "rust_analyzer" }
local special_configs = {
  rust_analyzer = {
    filetypes = {"rust"},
    root_dir = lspconfig.util.root_pattern("Cargo.toml")
  }
}

for _, lsp in ipairs(servers) do
  local basic = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if special_configs[lsp] ~= nil then
    lspconfig[lsp].setup(
      vim.tbl_deep_extend("force", basic, special_configs[lsp])
    )
  else
    lspconfig[lsp].setup(basic)
  end
end

