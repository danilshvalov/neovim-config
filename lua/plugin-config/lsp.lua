local nvim_lsp = require('lspconfig')

-- Mappings.
local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local opts = {noremap = true, silent = true}
set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
set_keymap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
           opts)
set_keymap('n', '<Leader>wr',
           '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
set_keymap('n', '<Leader>wl',
           '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
           opts)
set_keymap('n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
set_keymap('n', '<Leader>e',
           '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
set_keymap('n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
           opts)
set_keymap('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'pyright', 'rust_analyzer', 'tsserver', 'jdtls'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {debounce_text_changes = 150}
    }
end
