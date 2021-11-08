local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

vim.opt.termguicolors = true
require("bufferline").setup {}

map('n', '<Leader>b', ':BufferLinePick<CR>', opts)
map('n', '<C-c>', ':BufferLinePickClose<CR>', opts)

