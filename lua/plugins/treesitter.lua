require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua" },
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
})
