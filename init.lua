-- Set <space> as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core modules
require('options')
require('keymaps')
require('UnrealCommands')

-- Load plugins
require ('plugins')
