-- Keymaps configuration file
-- Define common key mappings for Neovim

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap exit insert mode to jk
map('i', 'jk', "<ESC>", { noremap = true, silent = true })
-----------------
-- Normal mode --
-----------------

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', 'o', "o<Esc>", { noremap = true, silent = true, desc = 'Append new line below' })
vim.keymap.set('n', 'O', "O<Esc>", { noremap = true, silent = true, desc = 'Append new line above' })
vim.keymap.set('n', '<c-h>', "<c-w>h", { noremap = true, silent = true, desc = 'Switch to Left Window' })
vim.keymap.set('n', '<c-l>', "<c-w>l", { noremap = true, silent = true, desc = 'Switch to Right Window' })
vim.keymap.set('n', '<c-j>', "<c-w>j", { noremap = true, silent = true, desc = 'Switch to Below Window' })
vim.keymap.set('n', '<c-k>', "<c-w>k", { noremap = true, silent = true, desc = 'Switch to Above Window' })
-----------------
-- Visual mode --
-----------------

-- [[ Use tab on visual mode ]]
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

----------------------
-- Terminal mappings --
----------------------
