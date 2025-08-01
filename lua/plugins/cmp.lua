local cmp = require("cmp")

cmp.setup({
    mappings = cmp.mapping.preset.insert({
        ['Tabs'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {{name = 'nvim_lsp'},},
})
