local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute("packadd packer.nvim")
end

local use = require("packer").use
local packer = require("packer").startup(function()
    -- Packer should manage itself
    use("wbthomason/packer.nvim")

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugin-config.null-ls")
        end,
    })

    use({
        "yamatsum/nvim-nonicons",
        requires = { "kyazdani42/nvim-web-devicons" },
    })

    use("rafamadriz/friendly-snippets")

    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugin-config.todo-comments")
        end,
    })

    use({
        "danilshvalov/tabout.nvim",
        config = function()
            require("plugin-config.tabout")
        end,
    })

    use("famiu/bufdelete.nvim")

    use({ "ellisonleao/glow.nvim" })

    use({
        "simrat39/rust-tools.nvim",
        config = function()
            require("plugin-config.rust-tools")
        end,
        after = "nvim-lspconfig",
    })

    use({
        "simrat39/symbols-outline.nvim",
        config = function()
            require("plugin-config.symbols-outline")
        end,
    })

    use({
        "is0n/fm-nvim",
        config = function()
            require("fm-nvim").setup({
                border = "single",

                border_hl = "FloatBorder",
                float_hl = "Normal",

                height = 0.9,
                width = 0.9,
            })
        end,
    })

    -- use({
    --     "mhartington/formatter.nvim",
    --     config = function()
    --         require("plugin-config/formatter")
    --     end,
    -- })

    use("fedepujol/move.nvim")

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugin-config/diffview")
        end,
    })

    -- use("norcalli/nvim-colorizer.lua")
    -- use({ "p00f/nvim-ts-rainbow", config = require("colorizer").setup() })

    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    use({
        "lervag/vimtex",
        config = function()
            require("plugin-config/vimtex")
        end,
    })

    -- use("jamestthompson3/nvim-remote-containers")

    use({ "iamcco/markdown-preview.nvim", run = [[sh -c 'cd app && npm install']] })

    use({ "nvim-lua/plenary.nvim" })

    use({
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").opts)
            require("plugin-config/alpha")
        end,
    })

    use({
        "SirVer/ultisnips",
        requires = "honza/vim-snippets",
        config = function()
            require("plugin-config/ultisnips")
        end,
    })
    use("quangnguyen30192/cmp-nvim-ultisnips")

    -- use({
    --     "dcampos/nvim-snippy",
    --     config = function()
    --         require(".plugin-config.snippy")
    --     end,
    --     requires = "dcampos/cmp-snippy",
    -- })

    -- use({
    --     "L3MON4D3/LuaSnip",
    --     config = function()
    --         require("plugin-config.luasnip")
    --     end,
    --     requires = "saadparwaiz1/cmp_luasnip",
    -- })

    -- add support for lua development
    use("folke/lua-dev.nvim")

    -- add interface for searching
    -- use({
    --     "VonHeikemen/searchbox.nvim",
    --     requires = { { "MunifTanjim/nui.nvim" } },
    --     config = function()
    --         require("plugin-config/search-box")
    --     end,
    -- })

    -- colorscheme
    use("folke/tokyonight.nvim")

    -- ┌───────────┐
    -- │ INTERFACE │
    -- └───────────┘

    -- tabline
    use({
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugin-config/bufferline")
        end,
    })

    use({
        "Yggdroot/indentLine",
        config = function()
            require("plugin-config/indent-guide-lines")
        end,
    })

    -- git integration
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugin-config/gitsigns")
        end,
    })

    -- auto close parenthesis
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("plugin-config/nvim-autopairs")
        end,
    })

    -- surround vim
    use("tpope/vim-surround")

    -- commenting
    use({
        "b3nj5m1n/kommentary",
        config = function()
            require("kommentary.config").configure_language("default", {
                prefer_single_line_comments = true,
            })
        end,
    })

    use({
        "famiu/feline.nvim",
        config = function()
            require("plugin-config/feline")
        end,
        after = "nvim-lspconfig",
    })

    -- lsp config
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("plugin-config/lsp")
        end,
    })

    -- for installing LSP servers within nvim
    use({
        "danilshvalov/nvim-lsp-installer",
        config = function()
            require("plugin-config/lsp-install")
        end,
    })

    -- neovim cmp
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugin-config/nvim-cmp")
        end,
    })

    -- support the missing lsp diagnostic colors
    use({
        "folke/lsp-colors.nvim",
        config = function()
            require("plugin-config/lsp-colors")
        end,
    })
    -- better LSP UI (for code actions, rename etc.)
    use({
        "tami5/lspsaga.nvim",
        config = function()
            require("plugin-config/lspsaga")
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-project.nvim" },
        },
        config = function()
            require("plugin-config/telescope")
        end,
    })
    -- Telescope extentions
    use("nvim-telescope/telescope-packer.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    -- use("fhill2/telescope-ultisnips.nvim")

    -- better highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugin-config/nvim-treesitter")
        end,
    })

    -- nvim & icons for nvim
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("plugin-config/nvim-tree")
        end,
    })

    -- -- nice diagnostic pane on the bottom
    use({
        "folke/lsp-trouble.nvim",
        config = function()
            require("plugin-config/lsp-trouble")
        end,
    })

    -- use({
    --     "mfussenegger/nvim-lint",
    --     config = function()
    --         require("plugin-config/nvim-lint")
    --     end,
    -- })

    -- terminal integration
    use({
        "akinsho/toggleterm.nvim",
        config = function()
            require("plugin-config/toggleterm")
        end,
    })

    -- help on key enter
    use({
        "folke/which-key.nvim",
        config = function()
            require("plugin-config/which-key")
        end,
    })

    use({
        "Shatur/neovim-session-manager",
        config = function()
            require("session_manager").setup({
                autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
            })
        end,
    })
end)

require("plugin-config.neovide")

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map("", "<Leader>ec", "<Cmd>PackerCompile<CR>", opts)

return packer
