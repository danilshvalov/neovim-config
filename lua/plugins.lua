local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
    execute 'packadd packer.nvim'
end

local use = require('packer').use
local packer = require('packer').startup(function()
    -- Packer should manage itself
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use 'shaunsingh/nord.nvim'
    use 'Mofiqul/dracula.nvim'

    -- tabline
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- git integration
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- auto close parenthesis
    use 'windwp/nvim-autopairs'

    -- formatting
    use 'sbdchd/neoformat'

    -- surround vim
    use 'tpope/vim-surround'

    -- commenting
    use 'b3nj5m1n/kommentary'

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- show recent files on empty nvim command
    use 'mhinz/vim-startify'

    -- lsp config
    use 'neovim/nvim-lspconfig'

    -- for installing LSP servers within nvim
    use 'kabouzeid/nvim-lspinstall'

    -- neovim cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- cmp snippets
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- TODO: prettify telescope vim, make it use regex & shorten the window
    -- telescope - searching / navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- better hotfix window (for showing and searching through results in telescope's find usages)
    use {"kevinhwang91/nvim-bqf"}

    -- better highlighting
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- nvim & icons for nvim
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    -- nice diagnostic pane on the bottom
    use 'folke/lsp-trouble.nvim'

    -- support the missing lsp diagnostic colors
    use 'folke/lsp-colors.nvim'

    -- better LSP UI (for code actions, rename etc.)
    use 'glepnir/lspsaga.nvim'

    -- show indentation levels
    use 'Yggdroot/indentLine'

    -- TODO: integrated lazygit
    -- https://github.com/kdheepak/lazygit.nvim

    use {
        'chipsenkbeil/distant.nvim',
        config = function()
            require('distant').setup {
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file's parent directory
                ['*'] = require('distant.settings').chip_default()
            }
        end
    }

    use 'mfussenegger/nvim-lint'

    -- easy motion
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        end
    }

    -- python docstring
    use 'heavenshell/vim-pydocstring'

end)

-- plugin specific configs go here
require('plugin-config/nvim-cmp')
require('plugin-config/telescope')
require('plugin-config/nvim-tree')
require('plugin-config/nvim-treesitter')
require('plugin-config/lsp-colors')
require('plugin-config/lsp-trouble')
require('plugin-config/lspsaga')
require('plugin-config/gitsigns')
require('plugin-config/indent-guide-lines')
require('plugin-config/lualine')
require('plugin-config/lsp')
require('plugin-config/neoformat')
require('plugin-config/nvim-lint')
require('plugin-config/hop')
require('plugin-config/bufferline')
require('plugin-config/pydocstring')
require('plugin-config/nvim-autopairs')

return packer
