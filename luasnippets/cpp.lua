local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix

return {
  s("in", fmt("#include <{}>", { i(1) })),
  s("inn", fmt('#include "{}"', { i(1) })),
  s("cout", fmt("std::cout << {} << std::endl;", { i(1) })),
  s("once", t("#pragma once")),
  s(
    "ns",
    fmta(
      [[
        namespace <> {

        <>

        } // <>
      ]],
      { i(1), i(0), rep(1) }
    )
  ),
  s(
    "main",
    fmta(
      [[
        int main() {
          <>
        }
      ]],
      { i(0) }
    )
  ),
}
