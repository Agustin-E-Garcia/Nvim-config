local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Buffer list
map('n', '<leader><leader>', '<cmd>Telescope buffers<cr>', opts)

-- Git files
map('n', '<leader>sg', '<cmd>Telescope git_files<cr>', opts)
