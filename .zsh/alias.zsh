alias ls='ls -a --group-directories-first --sort=extension --color=auto'
alias clipbd='xclip -selection clipboard'
# alias manim='manim --media_dir "$HOME/manimations/renders"'
alias pymode='source ~/venvs/py/bin/activate'
alias evimrc='cd $DOT_DIR && nvim .vim/.vimrc'
alias ezshrc='cd $DOT_DIR && nvim .zsh/.zshrc'
alias screenright='xrandr --auto && xrandr --output HDMI-2 --right-of eDP-1'
alias screenleft='xrandr --auto && xrandr --output HDMI-2 --left-of eDP-1'
alias screenoff='xrandr --auto && xrandr --output HDMI-2 --off'
alias dropbox='nohup ~/.dropbox-dist/dropboxd &'
alias mergepdfs='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf'
alias work='cd ~/ConvexOpt/code && pipenv shell && nvim'

# Functions
log () { echo "$(date '+%D %T') $@" >> ~/log.txt }
