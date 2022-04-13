" We auto jump so this sort of acts like a select
nnoremap <buffer> l :AerialClose<cr>

" Collapse whole tree
nnoremap <buffer> H :AerialTreeCloseAll<cr>

" Collapse level
nnoremap <buffer> h :AerialTreeClose<cr>

" Sync the folds, not sure it works, remove if broken
nnoremap <buffer> s :AerialTreeSyncFolds<cr>

" Toggle Current fold
nnoremap <buffer> <space> :AerialTreeToggle<cr>

" Move up and follow
nnoremap <buffer> k k:lua require("aerial").select({jump=false})<cr>

" Move down and follow
nnoremap <buffer> j j:lua require("aerial").select({jump=false})<cr>
