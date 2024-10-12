let g:mapleader=" "
let g:maplocalleader="\\"

set number
set relativenumber

set cursorline
set cursorlineopt=number

set expandtab
set shiftround
set tabstop=4
set shiftwidth=4

set splitbelow
set splitright

set ignorecase
set smartcase

set list
set listchars=tab:\ \ ,trail:·,nbsp:+

set shortmess+=I

set nowrap

set belloff=all

set mouse=a

set sidescrolloff=3
set scrolloff=5

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
call plug#end()

set termguicolors
set background=dark
colorscheme retrobox
