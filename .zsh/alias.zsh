# Command defaults
alias ls='ls -a --group-directories-first --sort=extension --color=auto'
alias clipbd='xclip -selection clipboard'

# Quickfiles
alias evimrc='cd $DOT_DIR && nvim .vim/.vimrc'
alias ezshrc='cd $DOT_DIR && nvim .zsh/.zshrc'
alias ealias='cd $DOT_DIR && nvim .zsh/alias.zsh'

# Screen
alias screenright='xrandr --auto && xrandr --output HDMI-2 --right-of eDP-1'
alias screenleft='xrandr --auto && xrandr --output HDMI-2 --left-of eDP-1'
alias screenoff='xrandr --auto && xrandr --output HDMI-2 --off'

# Apps
alias dropbox='nohup ~/.dropbox-dist/dropboxd &'

# Setups
alias dwrite='cd ~/Desktop/write'
alias dhaskell='cd ~/Desktop/haskell && stack ghci'
alias dpython='cd ~/Desktop/python'
alias dread='cd ~/Desktop/read && evince'

# Commands
alias mergepdfs='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf'

# Functions
log () { echo "$(date '+%D %T') $@" >> ~/log.txt }
