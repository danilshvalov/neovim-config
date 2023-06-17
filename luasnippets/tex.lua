local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix

local function text(trig, value)
  return s({ trig = trig, wordTrig = false }, t(value))
end

local function const(trig, value)
  return text("\\" .. trig, "\\" .. value)
end

local function wrap_with(trig, lhs, rhs, exit)
  return s({ trig = trig, wordTrig = false }, { t(lhs), i(exit and 0 or 1), t(rhs) })
end

local function cmd(trig, value)
  return wrap_with("\\" .. trig, "\\" .. value .. "{", "}")
end

local function env(trig, env_name, params)
  return wrap_with(
    trig,
    { "\\begin{" .. env_name .. "}" .. (params or ""), "\t" },
    { "", "\\end{" .. env_name .. "}" },
    true
  )
end

local function list_env(trig, env_name, params)
  return wrap_with(
    trig,
    { "\\begin{" .. env_name .. "}" .. (params or ""), "\t\\item " },
    { "", "\\end{" .. env_name .. "}" },
    true
  )
end

local function pf(trig, ...)
  return postfix({ trig = trig, match_pattern = "[%S]+$" }, { ... })
end

local function pf_wrap(trig, value)
  return pf(trig, l("\\" .. value .. "{" .. l.POSTFIX_MATCH .. "}"))
end

local function frac(trig, value)
  return s(
    { trig = "\\" .. trig, wordTrig = false },
    fmta("\\" .. value .. "{<>}{<>}", { i(1), i(2) })
  )
end

return {
  s(
    "beg",
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      { i(1), i(0), rep(1) }
    )
  ),
  wrap_with("mk", "\\(", "\\)"),
  wrap_with("dm", { "\\[", "\t" }, { "", "\\]" }, true),
  cmd("bf", "textbf"),
  cmd("it", "textit"),
  cmd("bb", "mathbb"),
  cmd("t", "text"),
  cmd("sec", "section"),
  cmd("secs", "section*"),
  cmd("sub", "subsection"),
  cmd("subs", "subsection*"),
  cmd("ssub", "subsubsection"),
  cmd("ssubs", "subsubsection*"),
  const("q", "quad"),
  const("qq", "qquad"),
  env("cas", "dcases*"),
  env("side", "siderules"),
  env("gs", "gather*"),
  env("eq", "equation"),
  env("ex", "example"),
  env("exs", "example*"),
  env("th", "theorem"),
  env("ths", "theorem*"),
  const("i", "item "),
  const("a", "alpha"),
  const("b", "beta"),
  const("g", "gamma"),
  const("l", "lambda"),
  const("p", "partial"),
  const("ve", "varepsilon"),
  const("vph", "varphi"),
  const("D", "Delta"),
  const("o", "omega"),
  const("O", "Omega"),
  list_env("item", "itemize"),
  list_env("enum", "enumerate"),
  list_env("enumc", "enumerate", "[wide, labelwidth=!, labelindent=0pt]"),
  frac("fr", "frac"),
  frac("dfr", "dfrac"),
  text("..", "\\ldots"),
  s("*", t("\\cdot")),
  text("->", "\\to"),
  text("<=", "\\leq"),
  text(">=", "\\geq"),
  text("!=", "\\neq"),
  text("=>", "\\implies"),
  pf_wrap(".bf", "textbf"),
}
