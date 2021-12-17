local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.formatting.prettier.with({
        filetypes = { "java", "markdown", "yaml", "json" },
        extra_args = function(params)
            return params.options
                and params.options.tabSize
                and {
                    "--tab-width",
                    params.options.tabSize,
                }
        end,
    }),
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--config-path", vim.fn.expand("~/stylua.toml") },
    }),
    -- null_ls.builtins.diagnostics.write_good,
    -- null_ls.builtins.diagnostics.chktex,
    -- null_ls.builtins.code_actions,
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.black.with({
        cmd = { "python3 -m black" },
        filetypes = { "python" },
        args = { "--line-length", "79", "--quiet", "-" },
    }),
}

null_ls.setup({
    sources = sources,
    save_after_format = true,
    filetypes = { "lua" },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePost <buffer> undojoin | lua vim.lsp.buf.formatting_sync()")
        end
    end,
})
