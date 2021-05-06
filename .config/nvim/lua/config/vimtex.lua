local g = vim.g

g.tex_flavour = 'latex'
g.tex_conceal = 'abdmg'

g.vimtex_fold_enabled = 1
g.vimtex_format_enabled = 1
g.vimtex_view_method = 'general'
g.vimtex_view_general_viewer = 'evince'
g.vimtex_view_forward_search_on_start = 0

g.vimtex_compiler_latexmk = { build_dir = 'build' }

g.Imap_UsePlaceHolders = 0
g.Tex_FoldedEnvironments = 'definition'
g.Tex_DefaultTargetFormat = 'pdf'

