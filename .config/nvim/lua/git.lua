local util = require('util')

local self = {}

function self.in_repo()
    local _, status = util.os_exec('git branch')
    return status == 0
end

function self.branch()
    -- try branch first
    local res, status = util.os_exec('basename $(git symbolic-ref HEAD 2> /dev/null)')
    if status == 0 then
        return res
    end

    -- try commit next
    res, status = util.os_exec('git rev-list --max-count=1 HEAD')
    if status == 0 then
        return string.sub(res, 0, 6)
    end

    -- Didn't work
    return nil
end

return self
