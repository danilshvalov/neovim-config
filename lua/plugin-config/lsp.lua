local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<Leader>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<Leader>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<Leader>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
map("n", "<Leader>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
-- map('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- map('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<Leader>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
map("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
-- map("n", "<Leader>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
map("n", ";f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

--[[ local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        flags = {
            debounce_text_changes = 150,
        },
    })
end ]]

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
    -- Needed for inlayHints. Merge this table with your settings or copy
    -- it from the source if you want to add your own init_options.
    capabilities = capabilities,
    init_options = require("nvim-lsp-ts-utils").init_options,
    --
    on_attach = function(client, bufnr)
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup({
            debug = false,
            disable_commands = false,
            enable_import_on_completion = true,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers = higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},

            -- inlay hints
            auto_inlay_hints = true,
            inlay_hints_highlight = "Comment",

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,
        })

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
    end,
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--[[ local servers = {'pyright', 'rust_analyzer', 'tsserver', 'taplo'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {debounce_text_changes = 150}
    }
end

require'lspconfig'.jdtls.setup {
    on_attach = on_attach,
    root_dir = require'lspconfig/util'.root_pattern(".git", "pom.xml")
} ]]
