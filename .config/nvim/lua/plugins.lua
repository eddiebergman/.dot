local joinpath = require('util').joinpath
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

        -- Doc generator
        use {
            "danymat/neogen"
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
                'dcampos/cmp-snippy', -- For snippy snippets
                'windwp/nvim-autopairs' -- For autopairs on function completions
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
                'nvim-lua/popup.nvim',
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
                'romgrk/nvim-treesitter-context',
            },
            config = function () require('config/treesitter') end,
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
            'rcarriga/vim-ultest',
            requires = { 'janko/vim-test' },
            config = function () require('util').setkeys("n", {
                {"<leader>un", "<cmd>UltestNearest<cr>"}
            })
            end
        }

        -- Theme
        use 'nightsense/stellarized'
    end
)
return M
