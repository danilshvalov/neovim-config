local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map("", "<Leader>td", "<Cmd>TodoTelescope<CR>", opts)

require("todo-comments").setup({
    keywords = {
        TODO = {
            color = "#e0af68",
        },
    },
    highlight = {
        keyword = "bg",
        pattern = [[(KEYWORDS)]],
        exclude = { "log" },
    },
    search = {
        pattern = [[\b(KEYWORDS)]],
    },
})
