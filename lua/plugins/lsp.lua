require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "omnisharp", "lua_ls", },
})

local lspconfig = require("lspconfig")

lspconfig.clangd.setup({})
lspconfig.omnisharp.setup({})
lspconfig.lua_ls.setup({ settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
