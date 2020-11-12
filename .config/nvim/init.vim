""""""""""""""""""""""""""""""""
" Vimrc
" Built with the help of https://donniewest.com/a-guide-to-basic-neovim-plugins/
" Really helpful post for beginners! Have a look.
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" General Vim switches
""""""""""""""""""""""""""""""""
let mapleader =" "

set modifiable
filetype plugin indent on
syntax on
set number relativenumber
set wildmode=longest,list,full
set nocompatible
set splitbelow splitright
set hlsearch
set scrolloff=10

" If a file was changed on disk but not inside nvim just reload it
set autoread
au CursorHold * checktime " see https://stackoverflow.com/a/18866818

" Incur indent from previous line. Makes work with messed up files much nicer
set autoindent
" And use some 'universal' default...
set tabstop=4
set shiftwidth=4

" do not break in the middle of a word
" set linebreak
" ident by an additional 4 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
set breakindentopt=shift:4,min:40,sbr
" append '>>' to indent
set showbreak=>>

" Use mouse in normal mode; best of both worlds ;)
set mouse=n

" First make search case insesitive. Then use the smartcase option to make it
" awesome. Smartcase implicitly overrides ignorecase for a single search and
" makes the search case sensitive if it finds an uppercase char in the search term.
set ignorecase
set smartcase

" Enable moving beyond last char of line. Makes d-b more comfy.
set virtualedit=onemore

" Enable highlighting of the current line
set cursorline

" Folding
set foldmethod=manual
set foldnestmax=10
set nofoldenable
set foldlevel=2
set nofoldenable
set ffs=unix,dos

set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Shortcuts for split navigation
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Copy text to clipboard
" NOTE: This requires gvim, nvim or vim-X11
vnoremap <C-c> "+y
map <A-p> "+P

" Set up listchars (hidden characters); useful when setting \":set list\"
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""
" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()

" Autocomplete awesomeness
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" enables completion of file paths
Plug 'ncm2/ncm2-path'
" enables language completions
Plug 'ncm2/ncm2-pyclang' " Clang/C/C++
" Plug 'ncm2/ncm2-jedi'    " Python

" Use ALE linter (that's the shit!)
Plug 'w0rp/ale'

" Airline status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'

" The fuzzy finder (also includes Ripgrep)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Filesystem tree viewer
Plug 'scrooloose/nerdtree'

" Tagbar
Plug 'majutsushi/tagbar'
if executable("ctags") != 1
  echo "ctags not found in path; Tagbar not fully functional"
endif

" Centered file view
Plug 'junegunn/goyo.vim'

" Surround text
Plug 'tpope/vim-surround'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Comment helper
Plug 'scrooloose/nerdcommenter'

" Colorscheme; looks just awesome in vim
Plug 'morhetz/gruvbox'

" Make moving splits less painful
Plug 'wesQ3/vim-windowswap'

call plug#end()

""""""""""""""""""""""""""""""""
" Plugin Config
""""""""""""""""""""""""""""""""
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" set completeopt to be what ncm2 expects
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" set completeopt=menu,menuone,preview,noselect,noinsert

" show full tag hierarchy in statusbar
let g:airline#extensions#tagbar#flags = 'f'
" theme in statusbar
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 0

" Make RipGrep highlight the matches
let g:rg_highlight = "true"

" Make NERDCommenter comment out empty lines; helps when
" commenting blocks and to make commented blocks stand
" out better
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" Use gruvbox theme
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='medium'
color gruvbox
set background=dark

" Taskwarrior
let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_rc_override = 'rc.defaultheight=0'

""""""""""""""""""""""""""""""""
" Macros and keymaps
""""""""""""""""""""""""""""""""

" if i have wraped lines i want to go to next/previous visual line
" not next/previous physical line!
noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap <C-p> :Files<ENTER>
if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
endif

" FZF
nmap <C-p> :Files<CR>

" Nerdtree
nmap <leader>n :NERDTreeFind<CR>
nmap <leader>N :NERDTreeClose<CR>

" Ncm2 completion menu with Tab
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make my preffered folding method less acrobatic
:nnoremap <leader>f zf%
:nnoremap <leader>o zo

""""""""""""""""""""""""""""""""
" Functions and Automatics
""""""""""""""""""""""""""""""""
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Show relative line numbers in normal mode and absolute in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" jump to the previous function
nnoremap <silent> [f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
nnoremap <silent> ]f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>
