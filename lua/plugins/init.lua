-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim/git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    { "nvim-telescope/telescope.nvim", dependencies = "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "lewis6991/gitsigns.nvim" },
    { "nvim-tree/nvim-tree.lua" },
    { "folke/tokyonight.nvim" },
})

-- Plugin-specific config files
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.cmp")
require("plugins.gitsigns")
require("plugins.nvimtree")
require("plugins.tokyonight")
