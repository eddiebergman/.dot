local M = {}

function M.exec(str)
    return vim.api.nvim_exec(str, true)
end

function M.system_name()
    if vim.fn.has("mac") == 1 then
        return "macOS"
    elseif vim.fn.has("unix") == 1 then
        return "Linux"
    elseif vim.fn.has("win32") then
        return "Windows"
    else
        print("system_name(): Unknown System")
        return -1
    end
end

function M.get(a, b)
    if not a == nil then return a else return b end
end

function M.os_exec(cmd)
    local handle = io.popen(cmd .. "; echo $?")
    local os_result = handle:read("*all")

    -- remove the return code at the end
    local cmd_result = os_result:gsub("\n(%d+)\n?$", "")

    -- match the return code at the end
    local exit_status = os_result:match("(%d+)\n?$")

    handle:close()
    return cmd_result, tonumber(exit_status)
end

function M.list(itr)
    if M.isarray(itr) then
        return itr
    end
    local t = {}
    for item in itr do
        table.insert(t, item)
    end
    return t
end

function M.strsplit(s, pat)
  pat = pat or '%s+'
  local st, g = 1, s:gmatch("()("..pat..")")
  local function getter(segs, seps, sep, cap1, ...)
    st = sep and seps + #sep
    return s:sub(segs, (seps or 0) - 1), cap1 or sep, ...
  end
  return function() if st then return getter(st, g()) end end
end

function M.executable(cmd)
    return vim.call("executable", cmd)
end

function M.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

function M.empty(t)
    return next(t) == nil
end

function M.find(t, pred)
    if type(t) ~= "table" then
        error("Only call find on tables")
    else
        for k, v in pairs(t) do
            if pred(v) then return k end
        end
        return nil
    end
end

function M.index(t, x)
   return M.find(t, function (v) return v == x end )
end

-- Not foolproof, just checks if first key is 1
function M.isarray(t)
    if type(t) ~= "table" then return false end

    if M.empty(t) then return true end

    local k, _ = next(t)
    if k == 1 then
        return true
    else
        return false
    end
end

function M.isdict(t)
    return type(t) == "table" and not M.isarray(t)
end

function M.foreach(iterable, f)
    if type(iterable) == "function" then
        for x in iterable do f(x) end
    else
        for k, v in pairs(iterable) do f(k, v) end
    end
end

function M.map_iter(f, gen, state, x)
    return function()
        local x = gen(state , x)
        if x ~= nil then return f(x) end
    end
end

function M.map(iterable, f)
    if type(iterable) == "function" then
        return M.map_iter(f, iterable)
    else
        local res = {}
        for k, v in pairs(iterable) do res[k] = f(v) end
        return res
    end
end

function M.filter_iter(f, gen, state, x)
    return function()
        local x = gen(state , x)
        if x ~= nil and f(x) then return x end
    end
end

function M.filter(iterable, f)
    if type(iterable) == "function" then
        return M.filter_iter(f, iterable)
    else
        local res = {}
        if M.isarray(iterable) then
            for _, x in ipairs(iterable) do
                if f(x) then table.insert(res, x) end
            end
        else
            for k, v in ipairs(iterable) do
                if f(v) then res[k] = v end
            end
        end
        return res
    end
end


function M.setkeys(mode, mappings, buffer)
    local default_opts = { silent = true, noremap = true }

    buffer = buffer or false
    if buffer == true then buffer = 0 end -- 0 is current buffer

    -- global mappings
    if buffer == false then
        local setkey = vim.api.nvim_set_keymap

        for _, mapping in ipairs(mappings) do
            local keys = mapping[1]
            local command = mapping[2]
            local opts = M.get(mapping[3], default_opts)
            setkey(mode, keys, command, opts)
        end

    -- buffer mappings
    else
        local setkey = vim.api.nvim_buf_set_keymap

        for _, mapping in ipairs(mappings) do
            local keys = mapping[1]
            local command = mapping[2]
            local opts = M.get(mapping[3], default_opts)
            setkey(buffer, mode, keys, command, opts)
        end
    end
end

-- Checks if a given path exists as a dir or file
function M.os_exists(path)
    local _, status = M.os_exec('[ -e "'..path..'" ]')
    if status == 0 then return true else return false end
end

function M.isfile(path)
    local _, status = M.os_exec('[ -f "'..path..'" ]')
    if status == 0 then return true else return false end
end

function M.isdir(path)
    local cmd = '[ -d "'..path..'" ]'
    local _, status = M.os_exec(cmd)
    if status == 0 then
        return true
    else
        return false
    end
end

function M.joinpath(...)
    return table.concat({...}, '/')
end

function M.str_split(s, delim)
    local items = {}
    for item in string.gmatch(s, delim) do
        table.insert(items, item)
    end
    return items
end

return M
