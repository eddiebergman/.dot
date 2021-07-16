-- https://github.com/kyazdani42/nvim-tree.lua

-- TODO: Doesn't seem to work as intended
vim.g.nvim_tree_disable_window_picker = 1

-- nvim-tree was hijacking and prevent netrw which disabled 'edit' on a
-- directory, which in typical vim opens a netrw explorer to select a file.
-- This was useful when editing files in an external directory, such as
-- editing snippets, vimrc etc...
vim.g.nvim_tree_hijack_netrw = 0
vim.g.nvim_tree_disable_netrw = 0

local tree_cv = nvimtree.nvim_tree_callback
local nvimtree = require('nvim-tree.config')
