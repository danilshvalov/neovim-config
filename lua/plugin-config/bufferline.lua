local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<A-Tab>", ":BufferLinePick<CR>", opts)
map("n", "<C-c>", ":BufferLinePickClose<CR>", opts)
map("n", "<A-Right>", ":BufferLineCycleNext<CR>", opts)
map("n", "<A-Left>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<S-A-Right>", ":BufferLineMoveNext<CR>", opts)
map("n", "<S-A-Left>", ":BufferLineMovePrev<CR>", opts)
map("n", "<Leader>q", "<Cmd>Bdelete<CR>", opts)
map("n", "<Leader>co", "<Cmd>%bd|e#|bd#<CR>", opts)
map("n", "<Esc>", "", opts)

map("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
map("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
map("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
map("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
map("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
map("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
map("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
map("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
map("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

require("bufferline").setup({
    options = {
        show_buffer_icons = false,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return tostring(count)
        end,
        numbers = function(opts)
            return opts.ordinal
        end,
    },
})
