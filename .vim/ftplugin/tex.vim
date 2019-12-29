command! BuildPDF execute '!bash %:p:t/buildpdf.sh'
nnoremap <leader>bd :BuildPDF<cr>
