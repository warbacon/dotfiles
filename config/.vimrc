syntax enable
filetype plugin indent on

if exists("$DISPLAY")
    set termguicolors
    set background=dark
    colorscheme retrobox
endif

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

set undofile

set nowrap

set sidescrolloff=3
set scrolloff=5

set wildmenu
set wildoptions+=pum
set pumheight=10

set mouse=a

set laststatus=2

set belloff=all

set hlsearch
nnoremap <silent> <C-l> :noh<CR>
