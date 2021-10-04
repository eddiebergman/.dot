local py = require('py')

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
    local handle = io.popen(cmd .." 2>/dev/null; echo $?")
    local os_result = handle:read("*all")

    -- remove the return code at the end
    local cmd_result = os_result:gsub("\n(%d+)\n?$", "")

    -- match the return code at the end
    local exit_status = os_result:match("(%d+)\n?$")

    handle:close()
    return cmd_result, tonumber(exit_status)
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


function M.contains(ele, lst)
    if M.isarray(lst) then
        for v in M.values(lst) do
            if v == ele then
                return true end end

        return false
    else
        for k in M.keys(lst) do
            if k == ele then
                return true end end

        return false
    end
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
