local M = {}

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(
    function(use)

        -- use { "pwntester/octo.nvim", config = function() require("config/octo").setup() end }
        use { '~/code/onhold/pyrate.nvim', disable = true }

        use 'wbthomason/packer.nvim'

        -- luadev
        use "folke/neodev.nvim"

        use {
            "startup-nvim/startup.nvim",
            config = function () require("homescreen").setup(true) end
        }

        -- hop
        use {
            "phaazon/hop.nvim",
            branch = "v2",
            config = function() require("config/hop").setup() end,
        }

        -- diagnostics project
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function() require("config/trouble").setup() end
        }

        -- zen
        use { "folke/zen-mode.nvim" }

        -- org
        -- use { "nvim-neorg/neorg", config = function() require("config/neorg").setup() end }
        -- use { "itchyny/calendar.vim" }

        use { 'stsewd/sphinx.nvim' }

        -- copilot?
        -- use {
        --    "github/copilot.vim"
        -- }
        --
        use {
            "akinsho/bufferline.nvim"
        }

        -- Minimap
        use {
            "gorbit99/codewindow.nvim",
            config = function() require("minimap").setup(false) end
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        use {
            "natecraddock/workspaces.nvim",
            config = function() require("workspace").setup() end
        }

        use {
            "L3MON4D3/LuaSnip",
            requires = { "rafamadriz/friendly-snippets" },
            config = function() require("luasnip.loaders.from_vscode").lazy_load() end
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
            config = function() require("symbol_tree").setup() end
        }

        use {
            "simrat39/symbols-outline.nvim"
        }

        -- Tree
        use { 'kyazdani42/nvim-tree.lua', requires = "kyazdani42/nvim-web-devicons" }

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
                'davidsierradz/cmp-conventionalcommits',
                -- 'hrsh7th/cmp-copilot',
            }
        }

        -- Neomake, run make and populate quickfix
        use {
            'neomake/neomake',
            config = function() require('config/neomake') end
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
            requires = { 'rcarriga/nvim-dap-ui', 'mfussenegger/nvim-dap-python' },
            config = function() require('config/dap') end
        }

        -- For preview and finding
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
            },
            config = function() require('config/telescope').setup() end
        }

        -- Language specific parsing based
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'nvim-treesitter/playground',
                'nvim-treesitter/nvim-treesitter-refactor',
                'RRethy/nvim-treesitter-textsubjects',
                'nvim-treesitter/nvim-treesitter-context',
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            run = ':TSUpdate'
        }

        -- Luapad for scratch lua
        use 'rafcamlet/nvim-luapad'

        -- Latex everything plugin
        use {
            'lervag/vimtex',
            config = function() require('config/vimtex') end,
            ft = { 'tex' }
        }

        -- Extra tex-concealing
        use {
            'KeitaNakamura/tex-conceal.vim',
            ft = { 'tex' }
        }

        use {
            'dcampos/nvim-snippy'
        }

        -- Git intergration
        use 'tpope/vim-fugitive'

        -- Surround selections
        use 'tpope/vim-surround'

        -- Enables repeats for more complicated actions
        use 'tpope/vim-repeat'

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
        use 'sainnhe/everforest'
        use 'morhetz/gruvbox'
        use 'NLKNguyen/papercolor-theme'
        use 'folke/tokyonight.nvim'
    end
)
return M
