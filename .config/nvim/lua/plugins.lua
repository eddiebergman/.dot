local M = {}

local cmd = vim.api.nvim_command
local exec = vim.api.nvim_exec
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_url =  'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', packer_url, install_path})
  cmd 'packadd packer.nvim'
end

function M.update()
    cmd 'PackerCompile'
    cmd 'PackerSync'
end

local function load (cfg)
    return function () require('config/'..cfg) end
end

require('packer').startup(
    function (use)
        -- Language Server
        use 'neovim/nvim-lspconfig'

        -- Autocomplete
        use {
            'hrsh7th/nvim-compe',
            config = load('compe')
        }

        -- User wiki
        use 'vimwiki/vimwiki'

        -- Latex everything plugin
        use {
            'lervag/vimtex',
            config = load('vimtex'),
            ft = {'tex'}
        }

        -- Extra tex-concealing
        use {
            'KeitaNakamura/tex-conceal.vim',
            ft = {'tex'}
        }

        -- Fuzzy find file names
        use {
            'ctrlpvim/ctrlp.vim',
            config = load('ctrlp')
        }

        -- Fuzzy find file contents
        use {
            'dyng/ctrlsf.vim',
            config = load('ctrlsf')
        }

        -- Snippet manager
        use {
            'SirVer/ultisnips',
            config = load('ultisnips')
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
