local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Esc>', '<cmd>nohlsearch<cr>')

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uitckfix list' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Higlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Search files
map('n', '<leader><leader>', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>sg', '<cmd>Telescope git_files<cr>', opts)
map('n', '<leader>sf', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>sd', '<cmd>Telescope diagnostics<cr>', opts)

-- LSP related on attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        map('n', '<leader>rn', vim.lsp.buf.rename)
        map('n', '<leader>gr', '<cmd>Telescope lsp_references<cr>')
        map('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>')
        map('n', '<leader>gi', '<cmd>Telescope lsp_implementations<cr>')
    end,
})
