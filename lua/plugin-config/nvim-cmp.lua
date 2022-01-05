-- Setup nvim-cmp.
--

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- local snippy = require("snippy")
require("cmp_nvim_ultisnips").setup({})
-- local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        -- ["<Tab>"] = function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expandable() then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        --         -- elseif require("tabout.tab").can_tabout("forward") then
        --         --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
        --     elseif luasnip.expand_or_jumpable() then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        --     else
        --         fallback()
        --     end
        -- end,
        -- ["<S-Tab>"] = function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif require("tabout.tab").can_tabout("backward") then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, true), "")
        --     elseif luasnip.jumpable(-1) then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        --     else
        --         fallback()
        --     end
        -- end,

        ["<CR>"] = function(fallback)
            if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_expand)"), "m", true)
            elseif cmp.visible() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end,

        ["<Tab>"] = function(fallback)
            -- if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            --     vim.api.nvim_feedkeys(t("<Plug>(ultisnips_expand)"), "m", true)
            --     -- elseif require("tabout.tab").can_tabout("forward") then
            --     --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, true), "")
            if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            -- if require("tabout.tab").can_tabout("backward") then
            --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, true), "")
            if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
            else
                fallback()
            end
        end,

        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif snippy.can_expand_or_advance() then
        --         snippy.expand_or_advance()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif snippy.can_jump(-1) then
        --         snippy.previous()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        --[[ ["<Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.compose({ "expand", "select_next_item" })(fallback)
        end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
        end, { "i", "s", "c" }), ]]
        --[[ ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }), ]]

        --[[ ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }), ]]
    },
    sources = cmp.config.sources({
        { name = "ultisnips" }, -- For ultisnips users.
        { name = "nvim_lsp" },
        -- {name = 'vsnip'}, -- For vsnip users.
        { name = "path" },
        -- { name = "luasnip" }, -- For luasnip users.
        -- { name = "snippy" }, -- For snippy users.
    }, { { name = "buffer" } }),
    completion = {
        autocomplete = false,
        get_trigger_characters = function(trigger_characters)
            return vim.tbl_filter(function(char)
                return char ~= " " and char ~= "\t"
            end, trigger_characters)
        end,
    },
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':'.
--[[ cmp.setup.cmdline(":", {
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
}) ]]
-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig").pyright.setup({ capabilities = capabilities })
require("lspconfig").jdtls.setup({ capabilities = capabilities })
