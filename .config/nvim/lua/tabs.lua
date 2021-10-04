local util = require('util')
local py = require('py')
local items, empty, index, map, enumerate, isinstance = py.items, py.empty, py.index, py.map, py.enumerate, py.isinstance

util.setkeys('n', {
    {"<leader>tn", "<cmd>tabnext<cr>"},
    {"<leader>tp", "<cmd>tabprev<cr>"}
})

local function tabs_tabline(tabname, tabnr)
    return "hello"
end

local _config = {
    tabs = {
        Src = {
            setup = function () end,
            key = "<leader>ts",
            on_startup = true,
            tabline = tabs_tabline
        },
        Test = {
            setup = function () vim.cmd("UltestSummary") end,
            key = "<leader>tt",
            on_startup = false,
            tabline = tabs_tabline
        },
        Todo = {
            setup = function () vim.cmd("edit ~/.todo.md") end,
            key = "<leader>to",
            on_startup = false,
            tabline = tabs_tabline
        },
        Debug = {
            setup = function () require('debugging').toggle_view() end,
            key = "<leader>td",
            on_startup = false,
            tabline = tabs_tabline
        }
    },
    dynamic_tabline = true,
}

local self = {
    -- [tabnr] = {
    --    name = ""
    --    tabline = func
    -- }
    tabs = { },
    defaul_tabline = vim.o.tabline
}

function self.setup(config)
    self.config = config or _config

    -- Set up a listener for tab closing
    vim.cmd([[
        augroup TabsListeners
            au!
            au TabClosed * lua require('tabs')._on_tab_close(vim.fn.expand('<afile>'))
            au TabNew * lua require('tabs')._on_tab_new(vim.fn.tabpagenr())
            au TabEnter * lua require('tabs')._on_tab_enter(vim.fn.tabpagenr())
        augroup END
    ]])

    -- Set hotkeys
    local function hotkey_command(name)
        return "<cmd>lua require('tabs').open('"..name.."')<cr>" end

    local hotkeys = {}
    for name, cfg in pairs(self.config.tabs) do
        table.insert(hotkeys, {cfg.key, hotkey_command(name)}) end
    util.setkeys("n", hotkeys)

    -- Open tabs that should be started up
    for name, cfg in items(self.config.tabs) do
        if cfg.on_startup then
            self.create_tab(name) end end

    -- If there was no tabs created, just register the first tab
    if empty(self.tabs) then
        self._on_tab_new(1) end
end


-- create_tab
--    Creates a new tab, setting it up and registering it in the table.
--
-- params
--    name: int | str - The name to give to the tab.
function self.create_tab(name)
    if self.tabs[name] then
        error(" Tab with name "..name.." already exists") end

    local tab = nil

    -- A named tab was created
    if self.config.tabs[name] ~= nil then
        local tabcfg = self.config.tabs[name]

        if tabcfg.tabline then
            tab = { name = name, tabline = tabcfg.tabline }
        else
            tab = { name = name, tabline = self.default_tabline } end
    end


    -- If the tabs list is empty then it is the first tab and we need simply
    -- add the entry
    if empty(self.tabs) then
        local this_tabnr = self.current_tab_number()
        table.insert(self.tabs, this_tabnr, tab)

    -- Otheriwse we create a new tab entry, insert it in and then spawn a new
    -- tab. Order is important because "tabnew" called the _on_tab_new which
    -- checks to see if an entry already exists.
    else
        local next_tabnr = self.current_tab_number() + 1
        table.insert(self.tabs, next_tabnr, tab)
        vim.cmd("tabnew") end

    -- Finally, set up the tab
    self.config.tabs[name].setup()

end


-- open
--    Opens a tab if it exists, else it creates a new one with that name
--
-- params
--    name: str - The name of the tab to open
function self.open(name)
    if self.is_open(name) then
        self.switch_to(name)
    else
        self.create_tab(name) end
end


function self.switch_to(tabnr_or_name)
    local tabnr = tabnr_or_name
    if type(tabnr_or_name) == "string" then
        tabnr = index(self.tabs, tabnr_or_name) end

    vim.cmd("tabnext "..tabnr)
end


function self._on_tab_enter(tabnr)
    if self.config.dynamic_tabline then
        return
    else
        vim.o.tabline = self.tabs[tabnr].tabline
    end
end

function self._on_tab_new(tabnr)
    -- If it was spawned by create_tab then there will be an entry
    if self.tabs[tabnr] ~= nil then
        return end

    -- Otherwise it was spawned by some other source so we name it by its
    -- number
    local tab = { name = tabnr, tabline=self.default_tabline }
    table.insert(self.tabs, tabnr, tab)

end

function self._on_tab_close(tabnr)
    -- Any tabs with numbers as names must be renamed
    for i, tab in enumerate(self.tabs) do
        if isinstance(self.tabs[i].name, "int") then
            self.tabs[i].name = i end end

    -- Remove it from our table
    table.remove(self.tabs, tonumber(tabnr))
end

function self.names() return map(self.tabs, function (t) return t.name end) end

function self.is_open(name) return self.tabs[name] ~= nil end

function self.total_tabs() return tonumber(vim.fn.tabpagenr('$')) end

function self.current_tab_number() return tonumber(vim.fn.tabpagenr()) end

self.tab_tabline = tabs_tabline

return self
