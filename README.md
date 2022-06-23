# Dot Files
Note: README is a little outdated

Hello, this is my collection of dot files. I run [Arch](https://archlinux.org/),
a minimilistic linux-distro which gives an extremely light weight operating
system at the cost of many hours/days/weeks required to learn the ins and outs
of managing your own system, aided by the wonderful [arch-wiki](https://wiki.archlinux.org/index.php/Arch_Linux)
and the `pacman` package manager.

![view_1](https://github.com/eddiebergman/.dot/blob/master/screenshots/image1.png)
![view_2](https://github.com/eddiebergman/.dot/blob/master/screenshots/image2.png)

Below is a list of a few key points of my setup:
## Vim - Editor
I primarly use Vim for most things text related.

The colorscheme is 'nightsense/stellarized' dark with a custom coded buffer
bar at the top.

Some core plugins in no particular order:
* [vimtex](https://github.com/lervag/vimtex) - For LaTeX related things
* [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git intergration
* [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) - Auto-complete
* [Syntastic](https://github.com/vim-syntastic/syntastic) - Intergrats with linters and syntax checkers
* [Ultisnips](https://github.com/SirVer/ultisnips) - code snipppets
* [NERDTree](https://github.com/scrooloose/nerdtree) - Tree like file navigation
* [CtrlP](https://github.com/ctrlpvim/ctrlp.vim) - Fuzzy file searcher
* [CtrlSF](https://github.com/dyng/ctrlsf.vim) - Fuzzy text searcher

![vim view](https://github.com/eddiebergman/.dot/blob/master/screenshots/image_vim.png)

## Zsh - Shell
As my shell I use [ZSH](https://www.zsh.org/) with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) as a plugin manager. There's not too much fancy going on here except the use of powerline10k as the prompt and zsh-autosuggestion for autocomplete suggestions.

My .zshrc has a few bits and bobs to help manage tasks, some custom PATH additions
and some sanity checks... My favourite is warning about the usage of `pip install`
while outside of a virtual env, it's saved from dependancy issues on too many occasions.

![zsh view](https://github.com/eddiebergman/.dot/blob/master/screenshots/image_shell.png)

---

## Qtile - Window Manager
As a window manager, I use [Qtile](http://www.qtile.org/), a window manager written
and configurable entirely in Python. Orginally I used [i3wm](https://i3wm.org/)
but my love of Python and a need for a fresh look got the better of me.

The entire look is custom made and will continue to be updated!

![qtile_view](https://github.com/eddiebergman/.dot/blob/master/screenshots/image_qtile.png)

---

## Rofi - Launcher
An upgrade of the classic [dmenu](https://tools.suckless.org/dmenu/), the
launcher [rofi](https://github.com/davatorium/rofi) can act run any programs
on `PATH`, switch to any open windows, fuzzy find through user files or
even act in custom configured ways such as filter through user specified
config files or even ssh into remote hosts.

I did some extra customization on it's appearance to fit the general
aesthetic used for vim and Qtile

![rofi view](https://github.com/eddiebergman/.dot/blob/master/screenshots/image_rofi.png)

---

## Kitty - Terminal
[Kitty](https://sw.kovidgoyal.net/kitty/) is a GPU based terminal which
supports many modern terminal features and has a very simple configuration.

Perhaps the biggest sell initially was simply ligatures, true-color, bold,
italics and bold-italics in a terminal along with its fast GPU based
rendering (`cat log.txt` never stood a chance). I've still never
had an actual issue with the terminal yet so I'll take that as a good sign.

However, any software which uses a `$TERM` and compares it against a
hard-coded list often does not include `kitty` and so some _linux foo_ may
be required here and there.

---

## Some other notable mentions
### Font
I mainly used Fira Code Mono for most editing, manually gotten 
from [here](https://github.com/Avi-D-coder/fira-mono-italic) but also installed by `fonts.install.sh`.

### LaTeX
I write documents in LaTeX so I've slowly been expanding a `preamble`
and i've made a quick document class I use for casual documents.

![tex view](https://github.com/eddiebergman/.dot/blob/master/screenshots/image_latex.png)

### File Browser - Dolphin
Normally I just navigate through a shell but having a file manager
is handy, dolphin seems quite nice but I havn't spent the time 
to configure it to look nice yet.

TEST
