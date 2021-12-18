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
        "VonHeikemen/fine-cmdline.nvim",
        requires = {
            { "MunifTanjim/nui.nvim" },
        },
        config = function()
            vim.api.nvim_set_keymap("n", "<F1>", "<cmd>FineCmdline<CR>", { noremap = true })
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

    use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

    use({
        "mhartington/formatter.nvim",
        config = function()
            require("plugin-config/formatter")
        end,
    })

    use({
        "mfussenegger/nvim-jdtls",
        config = function()
            require("plugin-config/jdtls")
        end,
    })

    use("fedepujol/move.nvim")

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugin-config/diffview")
        end,
    })

    use("norcalli/nvim-colorizer.lua")
    use({ "p00f/nvim-ts-rainbow", config = require("colorizer").setup() })

    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    use({
        "lervag/vimtex",
        config = function()
            require("plugin-config/vimtex")
        end,
    })

    use("jamestthompson3/nvim-remote-containers")

    use({ "iamcco/markdown-preview.nvim", run = [[sh -c 'cd app && npm install']] })

    -- use("gelguy/wilder.nvim")

    use({ "ellisonleao/glow.nvim" })

    use({ "nvim-lua/plenary.nvim" })

    use({
        "tanvirtin/vgit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugin-config/vgit")
        end,
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

    -- add support for lua development
    use("folke/lua-dev.nvim")

    -- add interface for searching
    use({
        "VonHeikemen/searchbox.nvim",
        requires = { { "MunifTanjim/nui.nvim" } },
        config = function()
            require("plugin-config/search-box")
        end,
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
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use({
        "famiu/feline.nvim",
        config = function()
            require("plugin-config/feline")
        end,
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
        "williamboman/nvim-lsp-installer",
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

    -- cmp icons
    use("onsails/lspkind-nvim")
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
    use("fhill2/telescope-ultisnips.nvim")
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
        branch = "chore/rewrite-renderer",
        config = function()
            require("plugin-config/nvim-tree")
        end,
    })

    -- nice diagnostic pane on the bottom
    use({
        "folke/lsp-trouble.nvim",
        config = function()
            require("plugin-config/lsp-trouble")
        end,
    })

    use({
        "mfussenegger/nvim-lint",
        config = function()
            require("plugin-config/nvim-lint")
        end,
    })

    -- python docstring
    use({
        "heavenshell/vim-pydocstring",
        config = function()
            require("plugin-config/pydocstring")
        end,
    })

    -- use("steelsojka/pears.nvim")

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

    -- pretty notifications
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("plugin-config/nvim-notify")
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

-- require("plugin-config/pears")
-- require("plugin-config/luasnip")
-- vim.cmd("source /Users/danilshvalov/.config/nvim/lua/plugin-config/wilder.vim")

return packer
