local M = {}

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(
    function (use)
        use 'wbthomason/packer.nvim'

        -- zen
        use { "folke/zen-mode.nvim" }

        -- org
        use {
            "nvim-neorg/neorg",
            config = function () require("config/neorg").setup() end
        }
        use {
            "itchyny/calendar.vim"
        }

        -- github
        use {
            'ldelossa/gh.nvim',
            requires= {{ 'ldelossa/litee.nvim' }}
        }

        use {
            'stsewd/sphinx.nvim'
        }

        -- copilot?
        -- use {
        --    "github/copilot.vim"
        -- }
        --
        use {
            "akinsho/bufferline.nvim"
        }

        use {
            "L3MON4D3/LuaSnip",
            requires = { "rafamadriz/friendly-snippets" },
            config = function () require("luasnip.loaders.from_vscode").lazy_load() end
        }

        -- Git integrations
        use {
            'lewis6991/gitsigns.nvim'
        }

        -- Doc generator
        use {
            "danymat/neogen"
        }

        -- Center a buffer
        use {
            'smithbm2316/centerpad.nvim'
        }

        -- Areial, symbol navigations
        use {
            "stevearc/aerial.nvim",
            disable = true,
            config = function () require("symbol_tree").setup() end
        }

        use {
            "simrat39/symbols-outline.nvim"
        }

        -- Tree
        use {
            'kyazdani42/nvim-tree.lua', requires = "kyazdani42/nvim-web-devicons"
        }

        -- Indent lines
        use {
           'lukas-reineke/indent-blankline.nvim'
        }

        use {
            'jose-elias-alvarez/null-ls.nvim'
        }

        -- Completion
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp', -- For LSP completion
                'hrsh7th/cmp-buffer', -- For buffer completion
                'hrsh7th/cmp-path', -- For path completion
                "saadparwaiz1/cmp_luasnip", -- for luasnip
                "lukas-reineke/cmp-under-comparator", -- For deprioritizing __ python
                'windwp/nvim-autopairs', -- For autopairs on function completions
                'hrsh7th/cmp-nvim-lsp-signature-help',
                -- 'hrsh7th/cmp-copilot',
            }
        }

        -- Neomake, run make and populate quickfix
        use {
            'neomake/neomake',
            config = function () require('config/neomake') end
        }

        -- vim-vinegar, slightly modified netrw
        use 'tpope/vim-vinegar'

        -- Language Server (LSP)
        use 'neovim/nvim-lspconfig'

        -- Folding for Python
        use { 'eddiebergman/nvim-treesitter-pyfold', ft = { 'python' } }

        -- Debugging
        use {
            'mfussenegger/nvim-dap',
            requires = {'rcarriga/nvim-dap-ui', 'mfussenegger/nvim-dap-python'},
            config = function () require('config/dap') end
        }

        -- For preview and finding
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
            },
            config = function () require('config/telescope').setup() end
        }

        -- Language specific parsing based
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'nvim-treesitter/playground',
                'nvim-treesitter/nvim-treesitter-refactor',
                'RRethy/nvim-treesitter-textsubjects',
                'lewis6991/nvim-treesitter-context',
            },
            run = ':TSUpdate'
        }

        -- Luapad for scratch lua
        use 'rafcamlet/nvim-luapad'

        -- User wiki
        use 'vimwiki/vimwiki'

        -- Latex everything plugin
        use {
            'lervag/vimtex',
            config = function () require('config/vimtex') end,
            ft = {'tex'}
        }

        -- Extra tex-concealing
        use {
            'KeitaNakamura/tex-conceal.vim',
            ft = {'tex'}
        }

        use {
            'dcampos/nvim-snippy'
        }

        -- Git intergration
        use 'tpope/vim-fugitive'

        -- Surround selections
        use 'tpope/vim-surround'

        -- Enables repeats for more complicated actions
        use  'tpope/vim-repeat'

        -- Autoclose braces
        use 'townk/vim-autoclose'

        -- Fzf engine
        -- use 'junegunn/fzf.vim'

        -- Testing
        use {
            'nvim-neotest/neotest',
            requires = {
                'nvim-lua/plenary.nvim',
                'antoinemadec/FixCursorHold.nvim',
                'nvim-neotest/neotest-python'
            },
        }

        -- Themes
        use 'nightsense/stellarized'
        use 'sainnhe/everforest'
        use 'morhetz/gruvbox'
        use 'NLKNguyen/papercolor-theme'
    end
)
return M
