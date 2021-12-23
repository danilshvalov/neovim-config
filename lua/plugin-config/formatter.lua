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
        typescriptreact = {
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
                    args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
                    stdin = true,
                    cwd = vim.fn.expand("%:p:h"),
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
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    stdin = true,
                }
            end,
        },
        toml = {
            -- prettier
            function()
                return {
                    exe = "taplo",
                    args = { "fmt", "-" },
                    stdin = true,
                }
            end,
        },
    },
})

require("formatter.util").print = function() end

vim.api.nvim_exec(
    [[
command ToggleFormat lua _G.should_format = not _G.should_format
]],
    false
)

_G.should_format = true

function _G.format_file()
    if _G.should_format then
        vim.api.nvim_command("FormatWrite")
    end
end

vim.api.nvim_exec(
    [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.java,*.lua,*.py,*.cpp,*.h,*.tex,*.rs,*.toml silent lua _G.format_file()
augroup END
]],
    true
)
