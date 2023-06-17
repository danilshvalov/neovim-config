-- local normal = vim.api.nvim_get_hl(0, { name = "Normal" })

-- vim.api.nvim_set_hl(0, "OrgHiddenStar", { fg = normal.bg })

-- for i = 1, 10 do
--   vim.cmd(
--     string.format(
--       [[syntax match OrgHiddenStar /^\*\{%d}\ze\s/me=e-1 containedin=OrgHeadlineLevel%d]],
--       i,
--       i
--     )
--   )
-- end
