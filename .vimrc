let mapleader = ","
execute pathogen#infect()
set encoding=utf-8 nobomb
set list
set listchars=tab:\|\ ,eol:¬,trail:·
set history=700
filetype plugin on
filetype indent on

set so=2

set ruler
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
set gdefault

set noerrorbells
set novisualbell

syntax enable
colorscheme desert

set nobackup

set noexpandtab
set shiftwidth=4
set tabstop=4

set hidden

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

autocmd vimenter * if !argc() | NERDTree | endif
