local self = {}

local util = require('util')

function self.setup()
    util.setkeys('n',{
        {'<leader>gp', ':Git push<cr>'},
        {'<leader>gc', ':Git commit<cr>'},
        {'<leader>gs', ':vertical bo Git<cr>'},
        {'<leader>gl', ':GcLog!<cr>'},
    })
end

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

function self.org_repo()
    remote = util.exec('echo FugitiveRemoteUrl()')
    if remote == '' then
        return ''
    end
    return remote.match(remote, ".+[%/:](.+%/.+)$")
end

return self
