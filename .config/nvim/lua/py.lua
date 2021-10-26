local M = {}

M.None = "__None__"

function M.empty(t)
    return next(t) == nil
end

function M.join(lst, s)
    local _s = s or ' '
    return table.concat(lst, _s)
end

-- not an iterator
-- only positive steps
-- Starts at 1 by default
-- inclusive endpoint
function M.range(a, b, step)
    if not b then
        b = a
        a = 1
    end
    step = step or 1
    local res = {}
    while a <= b do
        table.insert(res, a)
        a = a + step
    end
    return res
end

function M.index(table, item)
    for k, v in M.items(table) do
        if v == item then
                return k end end
    return nil
end

function M.isinstance(obj, typestr)
    if typestr == "int" or typestr == "float" then
        typestr = "number" end

    if type(obj) == "table" then
        -- table is table
        if typestr == "table" then
            return true end

        -- empty is list or dict
        if M.empty(obj) and (typestr == "list" or typestr == "dict") then
            return true
        end

        -- table with 1 in first index is list
        local idx, _ = next(obj)
        if idx == 1 and typestr == "list" then
            return true
        end

        -- the table is a dict in not a list
        if typestr == "dict" then
            return true
        end

        return type(obj) == typestr

    else
        return type(obj) == typestr end
end

function M.filter(iterable, f)
    local function iter_filter(gen, state, ...)
        local values = {...}
        return function()
            repeat values = {gen(state, unpack(values))}
            until not values[1] or f(unpack(values))
            return unpack(values)
        end
    end

    if type(iterable) == "function" then
        return iter_filter(iterable)
    elseif type(iterable) == "table" then
        return iter_filter(pairs(iterable))
    end
end

function M.map(iterable, f)
    local function iter_map(f, gen, state, ...)
        local values = {...}
        return function()
            values = {gen(state, unpack(values))}
            if values[1] ~= nil then
                return f(unpack(values)) end
        end
    end

    if type(iterable) == "function" then
        return iter_map(iterable)
    elseif type(iterable) == "table" then
        return iter_map(pairs(iterable))
    end
end

function M.reduce(iterable, acc, f)
    local function iter_reduce(gen, state, ...)
        local values = {...}
        return function()
            values = {gen(state, unpack(values))}
            if values[1] ~= nil then
                return f(acc, unpack(values)) end
        end
    end

    if type(iterable) == "function" then
        return iter_reduce(iterable)
    elseif type(iterable) == "table" then
        return iter_reduce(pairs(iterable))
    end
end

function M.list(itr)
    if M.isinstance(itr, "list") then
        return itr

    elseif M.isinstance(itr, "dict") then
        return M.keys(itr) end

    local t = {}
    for k, v in unpack{itr} do
        table.insert(t, k) end

    return t
end

function M.dict(itr)
    if M.isinstance(itr, 'dict') then
        return itr end

    local t = {}
    for k, v in unpack{itr} do
        t[k] = v end

    return t
end

function M.enumerate(iterable)
    if M.isinstance(iterable, "dict") then
        return ipairs(M.list(M.keys(iterable)))

    elseif M.isinstance(iterable, "list") then
        return ipairs(iterable) end

    local function iter_enumerate(gen, state, ...)
        local i = 0
        local values = {...}
        return function()
            values = {gen(state, unpack(values))}
            if values[1] ~= nil then
                i = i + 1
                return i, unpack(values) end
        end
    end

    return iter_enumerate(iterable)
end

function M.items(dict)
    return pairs(dict)
end

function M.values(dict)
    local gen, state, k, v = pairs(dict)
    return function ()
        k, v = gen(state, k, v)
        if v ~= nil then return v end
    end
end

function M.keys(dict)
    local gen, state, k, v = pairs(dict)
    return function ()
        k, v = gen(state, k, v)
        if k ~= nil then return k end
    end
end

function M.update(d1, d2)
    if not M.isinstance(d2, 'dict') then
        return
    end

    for key in M.keys(d2) do
        if not M.isinstance(d1[key], 'dict') then
            d1[key] = d2[key]
        elseif M.empty(d2[key]) then
            d1[key] = {}
        else
            M.update(d1[key], d2[key])
        end
    end
    return d1
end

return M
