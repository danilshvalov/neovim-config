local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

vim.opt.termguicolors = true
require("bufferline").setup {
 show_buffer_icons = false
}

map('n', '<A-Tab>', ':BufferLinePick<CR>', opts)
map('n', '<C-c>', ':BufferLinePickClose<CR>', opts)
map('n', '<A-Right>', ":BufferLineCycleNext<CR>", opts)
map('n', '<A-Left>', ":BufferLineCyclePrev<CR>", opts)
map('n', '<S-A-Right>', ":BufferLineMoveNext<CR>", opts)
map('n', '<S-A-Left>', ":BufferLineMovePrev<CR>", opts)
map('n', '<Leader>q', ':bd<CR>', opts)
map('n', '<Leader>co', [[<Cmd>%bd|e#|bd#<Cr>|'"<Cr>]], opts)
