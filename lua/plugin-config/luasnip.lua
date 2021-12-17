local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")

ls.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = true,
})

ls.snippets = {
    all = {
        s({ trig = "(%d)fr", regTrig = true, wordTrig = false }, {
            t("\\frac{"),
            f(function(_, snip)
                return snip.captures[1]
            end, {}),
            t("}{"),
            i(1),
            t("}"),
            i(0),
        }),
        s({ trig = "fr", regTrig = true, wordTrig = false }, {
            t("\\frac{"),
            i(1),
            t("}{"),
            i(2),
            t("}"),
            i(0),
        }),
    },
}

