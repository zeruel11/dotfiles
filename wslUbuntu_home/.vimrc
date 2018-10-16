call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'yegappan/mru'
" Code to execute when the plugin is lazily loaded on demand
" ggle file browser
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Both options are optional. You don't have to install fzf in ~/.fzf
" and you don't have to run install script if you use fzf only in Vim.
autocmd! User goyo.vim echom 'Goyo is now loaded!'
call plug#end()

map <F2> <Esc>:NERDTreeToggle<CR> "Toggle file browser
map <A-F1> <Esc>:NERDTreeFind<CR> "Find current file in browser

map <Leader>t <Esc>:FZF<CR>

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
