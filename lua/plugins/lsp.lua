require("mason").setup()

vim.lsp.config('clangd', {});
vim.lsp.config('omnisharp', {});
vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
