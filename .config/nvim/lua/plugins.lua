local M = {}

--local theme_package = "~/.dot/.config/nvim/darkme"
local command = require("util").command

local function plugins(use)
    use("wbthomason/packer.nvim")
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                position = "right",
                auto_preview = false,
                multiline = false,
                keys = {
                    ["q"] = "close",
                    ["<space>"] = "fold_toggle",
                    ["H"] = "fold_close_all",
                    ["h"] = "fold_close",
                    ["l"] = "fold_open",
                    ["L"] = "fold_open_recursive",
                    ["<C-S>"] = "close",
                },
                auto_jump = true,
                use_diagnostic_signs = true,
            })
            vim.api.nvim_set_keymap(
                "n",
                "<C-s>",
                "<cmd>Trouble symbols toggle focus=true win.position=left<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<C-l>",
                "<cmd>Trouble diagnostics toggle focus=true win={position=right, size={width=0.33}} filter.severity={min=vim.diagnostic.severity.WARN}<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>tt",
                "<cmd>Trouble todo toggle focus=true win.position=bottom<cr>",
                { noremap = true, silent = true }
            )
        end,
    })
    use({
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                direction = "vertical",
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.5
                    end
                end,
            })

            vim.api.nvim_set_keymap(
                "n",
                "<C-/>",
                "<cmd>lua require('toggleterm').toggle()<CR>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "i",
                "<C-/>",
                "<cmd>lua require('toggleterm').toggle()<CR>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "t",
                "<C-/>",
                "<cmd>lua require('toggleterm').toggle()<CR>",
                { noremap = true, silent = true }
            )
        end,
    })
    use({
        "mhartington/formatter.nvim",
        config = function()
            require("config/formatter").setup()
        end,
    })
    use({
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup({
                variant = "moon", -- auto, main, moon, or dawn
                dark_variant = "moon", -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                    migrations = true, -- Handle deprecated options automatically
                },

                styles = { bold = true, italic = false, transparency = false },

                groups = {
                    border = "muted",
                    link = "iris",
                    panel = "surface",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    note = "pine",
                    todo = "rose",
                    warn = "gold",

                    git_add = "foam",
                    git_change = "rose",
                    git_delete = "love",
                    git_dirty = "rose",
                    git_ignore = "muted",
                    git_merge = "iris",
                    git_rename = "pine",
                    git_stage = "iris",
                    git_text = "rose",
                    git_untracked = "subtle",

                    h1 = "iris",
                    h2 = "foam",
                    h3 = "rose",
                    h4 = "gold",
                    h5 = "pine",
                    h6 = "foam",
                },

                highlight_groups = {
                    CursorLineNr = { fg = "love" },

                    Cursor = { fg = "love", bg = "love" },
                    iCursor = { fg = "love" },
                    TermCursor = { fg = "love" },
                    CursorLine = { bg = "love", blend = 10 },
                    StatusLine = { fg = "love", bg = "love", blend = 30 },
                    StatusLineNC = { fg = "love", bg = "love", blend = 10 },
                    TelescopeNormal = { fg = "subtle" },
                    TelescopeSelection = { fg = "love", bg = "love", blend = 10 },
                    TelescopeSelectionCaret = { fg = "love" },
                    TelescopeMultiSelection = { fg = "text" },

                    TelescopeTitle = { fg = "love", bg = "love", blend = 10 },
                    TelescopePromptTitle = { fg = "love", bg = "love", blend = 10 },
                    TelescopePreviewTitle = { fg = "love", bg = "love", blend = 10 },
                    ["@constant"] = { fg = "rose" },
                    ["@lsp.type.namespace.zig"] = { fg = "text", italic = false },

                    WinSeparator = { fg = "love" },

                    LspInlayHint = { fg = "gold", bg = "base", italic = true },

                    DapUIVariable = { fg = "gold", italic = false },
                    DapUIValue = { fg = "foam" },
                    DapUIType = { fg = "love", italic = false },
                    DapUIFrameName = { fg = "subtle", italic = false },

                    NvimDapVirtualText = {
                        fg = "foam",
                        bg = "foam",
                        blend = 10,
                        italic = false,
                    },
                },
            })
        end,
    })
    use({
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = function()
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
            vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

            -- UFO
            vim.o.foldexpr = nil
            vim.o.foldcolumn = "0" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            require("ufo").setup({
                open_fold_hl_timeout = 0,
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
                fold_virt_text_handler = function(
                    virtText,
                    lnum,
                    endLnum,
                    width,
                    truncate
                )
                    local newVirtText = {}
                    local suffix = (" [%d]"):format(endLnum - lnum)
                    local sufWidth = vim.fn.strdisplaywidth(suffix)
                    local targetWidth = width - sufWidth
                    local curWidth = 0
                    for _, chunk in ipairs(virtText) do
                        local chunkText = chunk[1]
                        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if targetWidth > curWidth + chunkWidth then
                            table.insert(newVirtText, chunk)
                        else
                            chunkText = truncate(chunkText, targetWidth - curWidth)
                            local hlGroup = chunk[2]
                            table.insert(newVirtText, { chunkText, hlGroup })
                            chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            -- str width returned from truncate() may less than 2nd argument, need padding
                            if curWidth + chunkWidth < targetWidth then
                                suffix = suffix
                                    .. (" "):rep(targetWidth - curWidth - chunkWidth)
                            end
                            break
                        end
                        curWidth = curWidth + chunkWidth
                    end
                    table.insert(newVirtText, { suffix, "MoreMsg" })
                    return newVirtText
                end,
            })
        end,
    })
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp").setup()
        end,
    })
    -- Mason
    -- Easy setup of many language specific tools and LSP servers to give "smarts" to the editor
    use({
        "williamboman/mason.nvim",
        requires = { { "williamboman/mason-lspconfig.nvim" } },
    })
    use({ "mrcjkb/rustaceanvim" })

    -- Telescope
    -- The popup window that lets you select files
    use({
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        module = "telescope",
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        config = function()
            require("config/telescope").setup()
        end,
    })
    use({
        "mfussenegger/nvim-dap",
        event = "VimEnter",
        -- I know this is the other way around but I just found this easier to group together
        -- and have a dedicated single entry point for `config`
        requires = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("config/dap").setup()
        end,
    })

    -- Neodev
    -- Editor smartness when editing your nvim files
    use({
        "folke/neodev.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, type = true },
            })
        end,
    })

    -- Comment
    -- Use for comment blocks and commenting lines
    use({
        "numToStr/Comment.nvim",
        event = "BufRead",
        config = function()
            require("Comment").setup({ mappings = { baisc = false, extra = false } })
        end,
    })

    -- Nice git utilities for changes to a file
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end,
    })

    -- Completion
    -- Suggestions as you type
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" }, -- For LSP completions
            { "hrsh7th/cmp-buffer" }, -- For buffer content completion
            { "hrsh7th/cmp-path" }, -- For path completion
            { "lukas-reineke/cmp-under-comparator", after = "nvim-cmp" }, -- Deprioritize double underscore in python
            { "windwp/nvim-autopairs", after = "nvim-cmp" }, -- Autopair brackets on function completion
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }, -- Signature help as you fill in functions
            { "saadparwaiz1/cmp_luasnip" },
            { "L3MON4D3/LuaSnip" }, -- Signature help as you fill in functions
        },
        config = function()
            require("config/nvim-cmp").setup()
        end,
    })

    use({
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("config/nvim-tree").setup()
        end,
    })

    -- Treesitter
    -- Language aware syntax tree and associated plugins
    use({
        "nvim-treesitter/nvim-treesitter",
        event = "VimEnter",
        requires = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                after = "nvim-treesitter",
            },
            {
                "nvim-treesitter/nvim-treesitter-context",
                module = "treesitter-context",
            },
        },
        config = function()
            require("config/treesitter").setup()
        end,
        run = ":TSUpdate",
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
                        rust = true,
                        ["*"] = false,
                    },
                })
            end, 100)
        end,
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
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
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
