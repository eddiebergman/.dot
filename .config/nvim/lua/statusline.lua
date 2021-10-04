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
        linecol = { seperator = { left='', right=''} }
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

function self.tabline()
    return join({
        hi('TL'),
        '%=',
        self.env(),
        self.git_branch()
    })
end

function self.active_statusline()
    return join({
        hi('SLactive'),
        self.line_col(),
        '   ',
        self.modified(),
        self.filepath(),
        hi('SLactive'),

    },'')
end

function self.modified()
    return join({
        hi('SLmodified')..'%m'
    })
end

function self.filepath()
    return join({
        hi('SLfilepathsep')..self.config.filepath.seperator.left,
        hi('SLfilepath')..'"%f"',
        hi('SLfilepathsep')..self.config.filepath.seperator.right
    })
end

function self.line_col()
    return join({
        hi('SLlinecol')..self.config.linecol.seperator.left,
        hi('SLlinecol')..'%l:%c',
        hi('SLlinecol')..self.config.linecol.seperator.right,
    })
end

function self.inactive_statusline()
    return join({hi('SLinactive')})
end

function self.git_branch()
    if not git.in_repo() then
        return ''
    end

    local branch = git.branch()
    if branch == nil then
        return ''
    end

    return join({
        hi('TLgitbranchsep')..self.config.branch.seperator.left,
        hi('TLpre')..'ref: '..hi('TLgitbranch')..branch,
        hi('TLgitbranchsep')..self.config.branch.seperator.right,
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
