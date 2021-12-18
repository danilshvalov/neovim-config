require("formatter").setup({
    filetype = {
        java = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                    stdin = true,
                }
            end,
        },
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = { "--config-path", vim.fn.expand("~/stylua.toml"), "-" },
                    stdin = true,
                }
            end,
        },
        python = {
            function()
                return {
                    exe = "python3 -m black",
                    args = {
                        "--line-length",
                        79,
                        "--stdin-filename",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        tex = {
            function()
                return {
                    exe = "latexindent",
                    args = {
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
    },
})

require("formatter.util").print = function() end

vim.api.nvim_exec(
    [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.java,*.lua,*.py,*.cpp,*.h,*.tex FormatWrite
augroup END
]],
    true
)
