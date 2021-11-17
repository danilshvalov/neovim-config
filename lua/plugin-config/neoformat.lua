-- global config
vim.g.neoformat_run_all_formatters = 1

-- python
vim.g.neoformat_python_black = {
    exe = "black",
    args = {"-l 79", "-q", "-"},
    stdin = 1
}
vim.g.neoformat_enabled_python = {'autopep8', 'black'}

-- format on save
vim.api.nvim_exec([[
augroup fmt
autocmd!
autocmd BufWritePre * silent :Neoformat
augroup END
]], true)
