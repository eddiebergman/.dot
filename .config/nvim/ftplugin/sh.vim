setlocal foldmethod=syntax
setlocal foldmarker={{{,}}}
" {{{ Syntax
exec 'hi shQuote gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi shDoubleQuote gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi shSingleQuote gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi shConditional gui=None' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi shDerefSimple gui=Italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Special')), 'fg', 'gui')
" }}}

