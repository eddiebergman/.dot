local joinpath = require('util').joinpath
local M = {}

local cmd = vim.api.nvim_command
local fn = vim.fn
M.plugin_path = joinpath(fn.stdpath('data'), 'site' , 'pack', 'packer', 'start')
M.packer_path = joinpath(M.plugin_path, 'packer.nvim')

if fn.empty(fn.glob(M.packer_path)) > 0 then
    local packer_url =  'https://github.com/wbthomason/packer.nvim'
    fn.system({'git', 'clone', packer_url, M.packer_path})
    cmd 'packadd packer.nvim'
end

function M.update()
    cmd 'PackerCompile'
    cmd 'PackerSync'
end

require('packer').startup(
    function (use)

        -- Language Server (LSP)
        use 'neovim/nvim-lspconfig'

        -- Folding for Python
        use '/home/skantify/code/nvim-treesitter-pyfold'

        -- Debugging
        use {
            'mfussenegger/nvim-dap',
            requires = { 'mfussenegger/nvim-dap-python' },
            config = function () require('config/dap') end
        }

        -- Lean Theroem Prover for nvim
        use {
            'Julian/lean.nvim',
            requires = {
                'leanprover/lean.vim',
            },
            ft = 'lean',
            config = function () require('config/lean') end
        }

        -- For preview and finding
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim'
            },
            config = function () require('config/telescope') end
        }

        -- Language specific parsing based
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'nvim-treesitter/playground',
                'nvim-treesitter/nvim-treesitter-refactor',
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            config = function ()  require('config/treesitter') end
        }

        -- Luapad for scratch lua
        use 'rafcamlet/nvim-luapad'

        -- Autocomplete
        use {
            'hrsh7th/nvim-compe',
            config = function () require('config/compe') end
        }

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

        -- Snippet manager
        use {
            'SirVer/ultisnips',
            config = function () require('config/ultisnips') end
        }

        -- Git intergration
        use 'tpope/vim-fugitive'

        -- Surround selections
        use 'tpope/vim-surround'

        -- Enables repeats for more complicated actions
        use  'tpope/vim-repeat'

        -- Tree file explorer
        use {
            'kyazdani42/nvim-tree.lua',
            requires = { 'kyazdani42/nvim-web-devicons' }
        }

        -- Autoclose braces
        use 'townk/vim-autoclose'

        -- Fzf engine
        use 'junegunn/fzf.vim'

        -- Airline status bar
        use 'vim-airline/vim-airline'

        -- Testing
        use {
            'rcarriga/vim-ultest',
            requires = { 'janko/vim-test' }
        }

        -- Theme
        use 'nightsense/stellarized'

    end
)

return M
