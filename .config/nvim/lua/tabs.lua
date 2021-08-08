local M = {}
local util = require('util')
local list, map, range, foreach = util.list, util.map, util.range, util.foreach

local _config = {
    tabs = {
        {
            name = "source",
            setup = function () end,
            key = "<leader>ts",
            on_startup = true
        },
        {
            name = "testing",
            setup = function () vim.cmd("UltestSummary") end,
            key = "<leader>tt",
            on_startup = false
        },
        {
            name = "todo",
            setup = function () vim.cmd("edit ~/.todo.md") end,
            key = "<leader>to",
            on_startup = true
        }
    }
}

M.state = {
    tabs = {},
}

function M.setup(config)
    if config == nil then
        config = _config
    end
    M.config = config

    -- Populate state
    for _, tabconfig in ipairs(config.tabs) do
        local tabname = tabconfig.name
        M.state.tabs[tabname] = {
            tabnr = nil,
            setup = tabconfig.setup
        }
    end

    -- Set up a listener for tab closing
    vim.cmd([[
        augroup TabsOnTabClose
            au!
            au TabClosed * lua require('tabs').OnTabClose(vim.fn.expand('<afile>'))
        augroup END
    ]])

    -- Set hotkeys
    local hotkeys = list(map(
        config.tabs,
        function (tab) return {tab.key, "<cmd>lua require('tabs').Open('"..tab.name.."')<cr>"} end
    ))
    util.setkeys("n", hotkeys)

    -- Open tabs that should be started up
    for _, tab in ipairs(config.tabs) do
        if tab.on_startup then
            tab.setup()
            M.state.tabs[tab.name]['tabnr'] = vim.fn.tabpagenr()
            vim.cmd("tabnew")
        end
    end

    -- Finally close the extra created tab go back to the first tab
    vim.cmd("tabclose | tabnext 1")
end

function M.TabNames()
    local n_tabs = vim.fn.tabpagenr('$')
    local tabnames = range(n_tabs)
    for name, tab in pairs(M.state.tabs) do
        if tab.tabnr ~= nil then tabnames[tab.tabnr] = name end
    end
    return tabnames
end

function M.TabNumbers()
    local tabs_str = vim.api.nvim_exec("tabs", true)
    return list(map(tabs_str:gmatch("Tab page (%d)"), tonumber))
end

function M.Open(name)
    local tab = M.state.tabs[name]

    -- Be on the tab if it's open somewhere
    if tab['tabnr'] ~= nil then

        -- Nothing if it's the already opened tab
        if vim.fn.tabpagenr() == tab.tabnr then
        return
        -- Else open it
        else
            vim.cmd("tabnext "..tab.tabnr)
        end

    -- Create a new tab, set it up and switch to it
    else
        vim.cmd("tabnew")
        tab.setup()
        tab['tabnr'] = vim.fn.tabpagenr()
    end
end

function M.OnTabClose(tabnr)
    tabnr = tonumber(tabnr)
    for _, tabstate in pairs(M.state.tabs) do

        if tabstate['tabnr'] ~= nil then

            -- Closed this tab
            if tabstate['tabnr'] == tabnr then
                tabstate['tabnr'] = nil
                --
            -- Higher tabs need to get decremented by one
            elseif tabstate['tabnr'] > tabnr then
                tabstate['tabnr'] = tabstate['tabnr'] - 1
            end

        end
    end
end

util.setkeys('n', {
    {"<leader>tn", "<cmd>tabnext<cr>"},
    {"<leader>tp", "<cmd>tabprev<cr>"}
})

return M
