require("mason").setup()

vim.lsp.config('clangd', {});
vim.lsp.config('omnisharp', {});
vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })

local fileType_to_server =
{
    c = "clangd",
    cpp = "clangd",
    cs = "omnisharp",
    lua = "lua_ls",
}

vim.api.nvim_create_autocmd("FileType",
{
    callback = function(event)
            local server = fileType_to_server[event.match]
            if server then
                vim.lsp.enable(server)
            end
    end,
})
