local M = {}

--local theme_package = "~/.dot/.config/nvim/darkme"
local command = require("util").command

local function plugins(use)
    use('wbthomason/packer.nvim')

    -- https://github.com/topics/neovim-colorscheme?o=desc&s=stars
    --use('folke/tokyonight.nvim')
    -- use({ "sainnhe/gruvbox-material" })
    -- use({ "catppuccin/nvim", config = function() require("config/catppuccin").setup() end })
    use({ "rebelot/kanagawa.nvim", config = function() require("config/kanagawa").setup() end })
    use({ "stevearc/oil.nvim", config = function() require("config/oil").setup() end })

    use(
        {
            "rcarriga/nvim-dap-ui",
            requires = { {"mfussenegger/nvim-dap", module = "dap"}, },
            config = function() require("config/dap").setup() end,
            event = "FileType python",
        }
    )
    use ({ "neovim/nvim-lspconfig", config = function() require("lsp").setup() end })
    use({
      "luckasRanarison/nvim-devdocs",
      cmd = "DevdocsOpen",
      config = function() require("config/devdocs").setup() end
    })
    use({
        "m4xshen/hardtime.nvim",
        event = "InsertEnter",
        requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = function() require("config/hardtime").setup() end
    })

    use({
        "rcarriga/nvim-notify",
        event = "VimEnter",
        config = function() require("config/nvim-notify").setup() end
    })


    -- Harpoon
    use({"ThePrimeagen/harpoon", cmd= {"HarpoonMark", "HarpoonView"}, config = function() require("config/harpoon").setup() end })

    -- Mason
    -- Easy setup of many language specific tools and LSP servers to give "smarts" to the editor
    use({
        "williamboman/mason.nvim",
        requires = { { "williamboman/mason-lspconfig.nvim" } },
    })

    -- Telescope
    -- The popup window that lets you select files
    use({
        'nvim-telescope/telescope.nvim',
        event = "VimEnter",
        requires = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = function() require('config/telescope').setup() end
    })

    -- Diffview
    use({
        'sindrets/diffview.nvim',
        cmd = "Diffview",
        requires = { "nvim-lua/plenary.nvim" },
        config = function() require('config/diffview').setup() end
    })

    -- Testing
    use({
        'nvim-neotest/neotest',
        cmd = "Neotest",
        requires = {
            'nvim-lua/plenary.nvim',
            { "antoinemadec/FixCursorHold.nvim", after = "neotest" },
            { "nvim-neotest/neotest-python", opt = true  },
        },
        config = function() require('config/neotest').setup() end
    })

    -- Neodev
    -- Editor smartness when editing your nvim files
    use({
        "folke/neodev.nvim",
        after = "nvim-lspconfig",
        config = function ()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, type = true }
            })
        end
    })

    -- Comment
    -- Use for comment blocks and commenting lines
    use({
        "numToStr/Comment.nvim",
        event = "BufRead",
        config = function() require("config/comment").setup() end
    })

    -- TodoComments
    -- Highlight TODOs, and comments
    use({
        "folke/todo-comments.nvim",
        event = "BufRead",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("config/todo-comments").setup() end
    })

    -- Lualine
    -- Just a nice looking tabline
    use({
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        requires = {
            { "arkav/lualine-lsp-progress", after = "lualine.nvim" },
            { 'kyazdani42/nvim-web-devicons' },
        },
        config = function() require("config/lualine").setup() end
    })

    -- Gitsigns
    -- Nice git utilities for changes to a file
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function() require("config/gitsigns").setup() end
    })

    -- Completion
    -- Suggestions as you type
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },                -- For LSP completions
            { "hrsh7th/cmp-buffer", },                  -- For buffer content completion
            { "hrsh7th/cmp-path" }, -- For path completion
            { "lukas-reineke/cmp-under-comparator", after="nvim-cmp"},  -- Deprioritize double underscore in python
            { "windwp/nvim-autopairs", after = "nvim-cmp" },               -- Autopair brackets on function completion
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp"  }, -- Signature help as you fill in functions
            { "saadparwaiz1/cmp_luasnip" },
            { "L3MON4D3/LuaSnip",  }, -- Signature help as you fill in functions
        },
        config = function() require("config/nvim-cmp").setup() end
    })

    -- Treesitter
    -- Language aware syntax tree and associated plugins
    use({
        "nvim-treesitter/nvim-treesitter",
        event = "VimEnter",
        requires = {
            {"nvim-treesitter/nvim-treesitter-textobjects", after="nvim-treesitter"},
            { "nvim-treesitter/nvim-treesitter-context", module="treesitter-context" },
        },
        config = function() require("config/treesitter").setup() end,
        run = ":TSUpdate"
    })

    -- Copilot
    use({
        "zbirenbaum/copilot.lua",
        after = { "nvim-cmp" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup({
                    suggestion = {
                        enabled = true,
                        auto_trigger = true,
                        keymap = {
                            next = "<A-]>",
                            prev = "<A-{>",
                        },
                    },
                    filetypes = {
                        python = true,
                        lua = true,
                        yaml = true,
                        markdown = true,
                        ["*"] = false
                    }
                })
            end, 100)
        end
    })

    -- Git integration
    -- Must have
    use("tpope/vim-fugitive")

    -- Surround text
    -- `ys<motion><surround-symbol>`
    -- i.e. `ysiw"`  - YankSelect inside word " - will surround current word with ""
    use("tpope/vim-surround")

    -- Smarter repeats with `.`
    use("tpope/vim-repeat")
end

function M.setup()
    M.ensure_installed()
    M.autocompile()
    require("packer").startup(plugins)
end

function M.ensure_installed()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

function M.autocompile()
    -- Recompile the plugins file upon write
    vim.cmd([[
        augroup packer_user_config
          autocmd!
          autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
    ]])
end

return M
