local lsp_installer = require("nvim-lsp-installer")
local util = require("lspconfig/util")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local root_files = {
    -- Single-module projects
    {
        "build.xml", -- Ant
        "pom.xml", -- Maven
        "settings.gradle", -- Gradle
        "settings.gradle.kts", -- Gradle,
        "Jabba.iml",
    },
    -- Multi-module projects
    { "build.gradle", "build.gradle.kts" },
}

lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- if server.name == "jdtls" then opts.root_dir = util.find_git_ancestor end
    --
    if server.name == "texlab" then
        opts.texlab = {
            chktex = {
                onEdit = false,
                onOpenAndSave = true,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                args = {},
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
        }
    end

    if server.name == "clangd" then
        opts.cmd = { "clangd", "--background-index", "--compile-commands-dir", "build" }
        opts.init_options = {
            compilationDatabasePath = "build",
        }
        opts.root_dir = util.root_pattern("build/compile_commands.json")
    end

    if server.name == "jdtls" then
        opts.root_dir = function(fname)
            for _, patterns in ipairs(root_files) do
                local root = util.root_pattern(unpack(patterns))(fname)
                if root then
                    return root
                end
            end
        end

        opts.on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end
    end

    -- if server.name == "jdtls" then

    --[[ opts.root_dir = function(fname)
            local root = util.root_pattern(".git")(fname)
            if root then return root end
        end ]]

    --[[ opts.on_attach = on_attach
        opts.root_dir = function() return ".git" end

    end ]]

    if server.name == "sumneko_lua" then
        opts = require("lua-dev").setup()
        --[[ opts.diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'}
        } ]]
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
    server:setup(opts)
end)
