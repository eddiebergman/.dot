local py = require('py')
local util = require('util')
local chains = require('chains')
local git = require('git')

local join = py.join
local update = chains.update

local function hi(str) return '%#'..str..'#' end

local self = {
    config = {
        branch = { seperator = { left='[', right=']'} },
        env = { seperator = { left='(', right=')'} },
        filepath = { seperator = { left='', right=''} },
        modified = { seperator = { left=' ', right=''} },
        filetype = { seperator = { left='', right='-'} },
        linecol = { seperator = { left='', right=''} },
        time = { seperator = { left='[', right=']'} },
        i3 = { seperator = { left='[', right=']'} }
    }
}

function self.setup(config)
    update(self.config).with(config)

    vim.cmd([[
    augroup Statusline
        autocmd!
        autocmd WinEnter,BufEnter * lua vim.wo.statusline = require('statusline').active_statusline()
        autocmd WinEnter,BufEnter * lua vim.go.tabline = require('statusline').tabline()
        autocmd WinLeave,BufLeave * lua vim.wo.statusline = require('statusline').inactive_statusline()
    augroup END
    ]])
end


function self.i3_workspace()
    if util.executable("jq") and util.executable("i3-msg") then
        cmd = 'i3-msg -t get_workspaces | jq ".[] | select(.focused==true).name" | cut -d"\\"" -f2'
        active_window = util.os_exec(cmd)
        return join({
            hi('TLi3sep')..self.config.i3.seperator.left,
            hi('TLpre')..'workspace: ',
            hi('TLi3')..active_window,
            hi('TLi3sep')..self.config.i3.seperator.right
        })
    else
        return ""
    end
end

function self.tabline()
    return join({
        hi('TL'),
        self.time(),
        self.i3_workspace(),
        '%=',
        hi('TL'),
        self.env(),
        self.git_branch()
    })
end

function self.active_statusline()
    return join({
        hi('SLactive'),
        hi('SLactive'),
        '%=',
        hi('SLactive'),
        self.modified(),
        self.filetype(),
        self.filepath(),
        self.line_col(),
        hi('SLactive'),
        '%=',
        hi('SLactive'),

    },'')
end

function self.filetype()
    return join({
        hi('SLfiletypesep')..self.config.filetype.seperator.left,
        hi('SLfiletype')..'%y',
        hi('SLfiletypesep')..self.config.filetype.seperator.right
    })
end

function self.modified()
    return join({
        hi('SLmodifiedsep')..self.config.modified.seperator.left,
        hi('SLmodified')..'%m',
        hi('SLmodifiedsep')..self.config.modified.seperator.right,
    }, '')
end

function self.filepath()
    return join({
        hi('SLfilepathsep')..self.config.filepath.seperator.left,
        hi('SLfilepath')..'%f',
        hi('SLfilepathsep')..self.config.filepath.seperator.right
    })
end

function self.line_col()
    return join({
        hi('SLlinecolsep')..self.config.linecol.seperator.left,
        hi('SLlinecol')..'%l:%c',
        hi('SLlinecolsep')..self.config.linecol.seperator.right,
    })
end

function self.inactive_statusline()
    return join({hi('SLinactive')})
end

function self.time()
    local res, _ = util.os_exec('date +%T')
    return join({
        hi('TLtimesep')..self.config.time.seperator.left,
        hi('TLtime')..res,
        hi('TLtimesep')..self.config.time.seperator.right
    })
end

function self.git_branch()
    if not git.in_repo() then
        return ''
    end

    local branch = git.branch()
    if branch == nil then
        return ''
    end

    local org_repo = git.org_repo()
    if org_repo == nil or org_repo == '' then
        return ''
    end


    return join({
        hi('TLgitsep')..self.config.branch.seperator.left,
        hi('TLpre')..'ref: '..hi('TLgitbranch')..branch..hi('TLgitorg')..' @ '..org_repo,
        hi('TLgitsep')..self.config.branch.seperator.right,
    },'')
end

function self.env()
    local env, status = util.os_exec('basename $VIRTUAL_ENV')
    if status ~= 0 then
        return ""
    end

    return join({
        hi('TLenvsep')..self.config.env.seperator.left,
        hi('TLpre')..'env: '..hi('TLenv')..env,
        hi('TLenvsep')..self.config.env.seperator.right,
    }, '')
end


return self
