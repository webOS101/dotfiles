" Some boilerplate code to get gvim on windows to load from home.  Copied from
"  http://stackoverflow.com/a/10622083

"g:my_vim_dir is used elsewhere in my vim configurations
let g:my_vim_dir=expand("$HOME/.vim")

"$HOME/.vim and $HOME/.vim/after are in the &rtp on unix
"But on windows, they need to be added.
if has("win16") || has("win32") || has("win64")
  "add g:my_vim_dir to the front of the runtimepath
   execute "set rtp^=".g:my_vim_dir
  "add g:my_vim_dir\after to the end of the runtimepath
  execute "set rtp+=".g:my_vim_dir."\\after"
  "Note, pathogen#infect() looks for the 'bundle' folder in each path
  "of the &rtp, where the last dir in the '&rtp path' is not 'after'. The
  "<path>\bundle\*\after folders will be added if and only if
  "the corresponding <path>\after folder is in the &rtp before
  "pathogen#infect() is called.  So it is very important to add the above
  "'after' folder.
  "(This applies to vim plugins such as snipmate, tabularize, etc.. that
  " are loaded by pathogen (and perhaps vundle too.))

  " Not necessary, but I like to cleanup &rtp to use \ instead of /
  " when on windows machines
  let &rtp=substitute(&rtp,"[/]","\\","g")

  "On windows, if called from cygwin or msys, the shell needs to be changed 
  "to cmd.exe to work with certain plugins that expect cmd.exe on windows versions   
  "of vim.
  if &shell=~#'bash$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
  endif
endif

let mapleader = ","

" ctrlp
let g:ctrlp_map = 'π'

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" ====== Default settings ======

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
set gdefault

set noerrorbells
set novisualbell

syntax enable
colorscheme desert

set nobackup
set noswapfile

set noexpandtab
set shiftwidth=4
set tabstop=4

set hidden

set laststatus=2
set showcmd

" Search up the directory for tags files
set tags=./tags;/

" ======= Key remaps and shortcuts ======

nnoremap <leader><space> :noh<cr>

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

" Faster search/replace
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

" When you forgot to sudo before editing
cmap w!! w !sudo tee % >/dev/null

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Fix up common shift-key-too-long typos
if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
    command! -bang Bn bn<bang>
    command! -bang Bp bp<bang>
    command! -bang Bw bw<bang>
endif

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
inoremap <silent> <Up> <Esc>gk
inoremap <silent> <Down> <Esc>gj

" Close buffer in split without closing split
nmap <leader>d :b#<bar>bd#<bar>b<CR>

" use normal regex in searches
" nnoremap / /\v
" vnoremap / /\v

" ====== Macros and special settings ======

"====[ Use persistent undo ]=================

if has('persistent_undo')
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/.vim/.vimundo

    " Save a lot of back-history...
    set undolevels=5000

    " Actually switch on persistent undo
    set undofile

endif

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vmap <expr> > ShiftAndKeepVisualSelection(">")
vmap <expr> < ShiftAndKeepVisualSelection("<")

function! ShiftAndKeepVisualSelection(cmd)
	set nosmartindent
	if mode() =~ '[Vv]'
		return a:cmd . ":set smartindent\<CR>gv"
	else
		return a:cmd . ":set smartindent\<CR>"
	endif
endfunction

"====[ Goto last location in non-empty files ]=======

autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif

" Open URL in line in browser (Mac only)
function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call HandleURI()<CR>

" ====== Plugin settings ======

"==== Markdown
let g:vim_markdown_folding_disabled=1

" Airline configuration
let g:airline_powerline_fonts = 1

" Yankring configuration
let g:yankring_history_dir = '$HOME/.vim'

" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('js', 'Red', 'none', 'SkyBlue', '#333333')
call NERDTreeHighlightFile('json', 'blue', 'none', 'salmon', '#333333')
call NERDTreeHighlightFile('css', 'LightGreen', 'none', 'palegreen', '#333333')
call NERDTreeHighlightFile('less', 'LightGreen', 'none', 'palegreen', '#333333')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'khaki', '#333333')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#333333')
call NERDTreeHighlightFile('txt', 'yellow', 'none', 'yellow', '#333333')

" gitgutter
let updatetime = 1000
highlight SignColumn guibg=black
highlight GitGutterAdd guibg=black
highlight GitGutterChange guibg=black
highlight GitGutterDelete guibg=black
highlight GitGutterChangeDelete guibg=black
highlight GitGutterAdd guifg=green
highlight GitGutterChange guifg=yellow
highlight GitGutterDelete guifg=red
highlight GitGutterChangeDelete guifg=orange

