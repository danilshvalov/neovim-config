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

    -- use({ "L3MON4D3/LuaSnip", requires = "saadparwaiz1/cmp_luasnip" })

    use("jose-elias-alvarez/null-ls.nvim")

    use({
        "AckslD/nvim-neoclip.lua",
        requires = { "tami5/sqlite.lua", module = "sqlite" },
        config = function()
            require("neoclip").setup({
                enable_persistant_history = true,
                db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
            })
        end,
    })

    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
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

    use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

    use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

    use("mhartington/formatter.nvim")

    use("mfussenegger/nvim-jdtls")

    use("fedepujol/move.nvim")

    use("norcalli/nvim-colorizer.lua")

    use({ "p00f/nvim-ts-rainbow", config = require("colorizer").setup() })

    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    use("lervag/vimtex")

    use("jamestthompson3/nvim-remote-containers")

    use({ "iamcco/markdown-preview.nvim", run = [[sh -c 'cd app && npm install']] })

    use("gelguy/wilder.nvim")

    use({ "ellisonleao/glow.nvim" })

    use({ "nvim-lua/plenary.nvim" })

    use({
        "tanvirtin/vgit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- lua with packer.nvim
    use({
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({
                mapping = { "jj", "jk" },
            })
        end,
    })

    use({
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").opts)
        end,
    })

    use({
        "SirVer/ultisnips",
        requires = "honza/vim-snippets",
        config = function()
            vim.g.UltiSnipsRemoveSelectModeMappings = 0
        end,
    })
    use("quangnguyen30192/cmp-nvim-ultisnips")

    -- add support for lua development
    use("folke/lua-dev.nvim")

    -- add interface for searching
    use({
        "VonHeikemen/searchbox.nvim",
        requires = { { "MunifTanjim/nui.nvim" } },
    })

    -- colorscheme
    use("shaunsingh/nord.nvim")
    use("Mofiqul/dracula.nvim")
    use("catppuccin/nvim")
    use("projekt0n/github-nvim-theme")
    use("rmehri01/onenord.nvim")
    use("folke/tokyonight.nvim")
    use("andersevenrud/nordic.nvim")

    -- ┌───────────┐
    -- │ INTERFACE │
    -- └───────────┘

    -- tabline
    use({
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })

    use("Yggdroot/indentLine")

    -- git integration
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

    -- auto close parenthesis
    use("windwp/nvim-autopairs")

    -- formatting
    use("sbdchd/neoformat")

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
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use("famiu/feline.nvim")

    -- lsp config
    use("neovim/nvim-lspconfig")

    -- for installing LSP servers within nvim
    use({ "williamboman/nvim-lsp-installer" })

    -- neovim cmp
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")

    -- cmp icons
    use("onsails/lspkind-nvim")
    -- support the missing lsp diagnostic colors
    use("folke/lsp-colors.nvim")
    -- better LSP UI (for code actions, rename etc.)
    use({ "tami5/lspsaga.nvim" })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-project.nvim" },
        },
    })
    -- Telescope extentions
    use("nvim-telescope/telescope-packer.nvim")
    use("fhill2/telescope-ultisnips.nvim")

    -- better highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- nvim & icons for nvim
    use({ "kyazdani42/nvim-tree.lua", branch = "chore/rewrite-renderer" })

    -- nice diagnostic pane on the bottom
    use("folke/lsp-trouble.nvim")

    use("mfussenegger/nvim-lint")

    -- python docstring
    use("heavenshell/vim-pydocstring")

    -- use({
    --     "lewis6991/spellsitter.nvim",
    --     config = function()
    --         require("spellsitter").setup({
    --             -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
    --             enable = true,

    --             -- Highlight to use for bad spellings
    --             hl = "SpellBad",

    --             -- Spellchecker to use. values:
    --             -- * vimfn: built-in spell checker using vim.fn.spellbadword()
    --             -- * ffi: built-in spell checker using the FFI to access the
    --             --   internal spell_check() function
    --             spellchecker = "ffi",
    --         })
    --     end,
    -- })

    -- terminal integration
    use("akinsho/toggleterm.nvim")

    -- help on key enter
    use("folke/which-key.nvim")

    -- pretty notifications
    use("rcarriga/nvim-notify")

    use({
        "Shatur/neovim-session-manager",
        config = require("session_manager").setup({
            autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        }),
    })
end)

require("plugin-config/lsp")
require("plugin-config/lsp-install")
require("plugin-config/nvim-cmp")
require("plugin-config/telescope")
require("plugin-config/nvim-tree")
require("plugin-config/nvim-treesitter")
require("plugin-config/lsp-colors")
require("plugin-config/lsp-trouble")
require("plugin-config/lspsaga")
require("plugin-config/gitsigns")
require("plugin-config/indent-guide-lines")
-- require("plugin-config/lualine")
require("plugin-config/feline")
require("plugin-config/neoformat")
require("plugin-config/nvim-lint")
require("plugin-config/bufferline")
require("plugin-config/pydocstring")
require("plugin-config/nvim-autopairs")
require("plugin-config/toggleterm")
require("plugin-config/which-key")
require("plugin-config/nvim-notify")
require("plugin-config/vifm")
require("plugin-config/search-box")
require("plugin-config/alpha")
require("plugin-config/vimtex")
require("plugin-config/vgit")
require("plugin-config/ultisnips")
require("plugin-config/jdtls")
require("plugin-config/formatter")
require("plugin-config/diffview")
require("plugin-config/null-ls")
require("plugin-config/neovide")
-- require("plugin-config/luasnip")
vim.cmd("source /Users/danilshvalov/.config/nvim/lua/plugin-config/wilder.vim")


return packer
