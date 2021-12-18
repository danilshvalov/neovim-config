local npairs = require("nvim-autopairs")
local map = vim.api.nvim_set_keymap

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

npairs.setup({
    check_ts = true,
    map_c_w = true,
    fast_wrap = {
        map = "<A-e>",
    },
})
