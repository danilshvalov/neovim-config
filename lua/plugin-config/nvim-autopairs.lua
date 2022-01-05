local npairs = require("nvim-autopairs")
local map = vim.api.nvim_set_keymap
local Rule = require("nvim-autopairs.rule")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

npairs.setup({
    check_ts = true,
    map_c_w = true,
    map_c_h = true,
    fast_wrap = {
        map = "<A-w>",
    },
    ignored_next_char = "[%w%.А-Яа-яё]",
})

npairs.add_rule(Rule('r#"', '"#', "rust"))
npairs.add_rule(Rule("\\Big(", "\\Big)"))
npairs.add_rule(Rule("\\{", "\\}"))
npairs.add_rule(Rule("\\(", "\\)"))
npairs.add_rule(Rule("\\[", "\\]"))

npairs.add_rules({
    Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),
    Rule("( ", " )")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%)") ~= nil
        end)
        :use_key(")"),
    Rule("{ ", " }")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%}") ~= nil
        end)
        :use_key("}"),
    Rule("[ ", " ]")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%]") ~= nil
        end)
        :use_key("]"),
})
