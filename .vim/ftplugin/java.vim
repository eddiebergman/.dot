setlocal foldmethod=syntax
let b:comment_leader = '// '
let b:line_ending = ';'

command! JavaRunFile execute '!javac % && java %'
