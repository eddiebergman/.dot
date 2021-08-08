local M = {}
local util = require('util')
local list, map = util.list, util.map

local _config = {
    tabs = {
        {
            name = "home",
            setup = function ()  end
        },
        {
            name = "testing",
            setup = function ()  end
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

    -- Set the first tab to be our current one
    local _, tabconfig = next(config.tabs)
    local tabname = tabconfig.name
    M.state.tabs[tabname]['tabnr'] = vim.fn.tabpagenr()
    tabconfig.setup()

    -- Set up a listener for tab closing
    vim.cmd([[
        augroup TabsOnTabClose
            au!
            au TabClosed * lua require('tabs').OnTabClose(vim.fn.expand('<afile>'))
        augroup END
    ]])
end

function M.OpenTabs()
    local tabs_str = vim.api.nvim_exec("tabs", true)
    return list(map(tabs_str:gmatch("Tab page (%d)"), tonumber))
end

function M.Open(name)
    for tabname, tabstate in pairs(M.state.tabs) do
        if name == tabname then
        
            -- Be on the tab if it's open
            if tabstate['tabnr'] ~= nil then

                -- Nothing if it's the already opened tab
                if M.state.current_tab == tabstate.tabnr then
                    return
                -- Else open it
                else
                    vim.cmd("tabnext "..tabstate.tabnr)
                end

            -- Create a new tab, set it up and switch to it
            else
                vim.cmd("tabnew")
                tabstate.setup()
                tabstate['tabnr'] = vim.fn.tabpagenr()
            end

        end
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
    -- [t]ab [t]est
    {"<leader>tt", "<cmd>lua require('tabs').Open('testing')<cr>"},
    {"<leader>th", "<cmd>lua require('tabs').Open('home')<cr>"},
    {"<leader>tn", "<cmd>tabnext<cr>"},
    {"<leader>tp", "<cmd>tabprev<cr>"}
})

return M
