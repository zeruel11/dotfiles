if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plug 'junegunn/vim-easy-align'
Plug 'will133/vim-dirdiff'
"Plug 'tpope/vim-sensible'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
call plug#end()

set number
syntax enable
set background=dark
colorscheme gruvbox
set mouse=a

if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

if &diff
    set cursorline
    set background=light
    let g:solarized_diffmode="high"
    let g:solarized_termcolors=256
    colorscheme solarized
    map ] ]c
    map [ [c
    set diffopt=filler,context:0
endif
