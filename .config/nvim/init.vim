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
set number
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
Plug 'neoclide/coc.nvim'

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

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'patstockwell/vim-monokai-tasty'

" Make moving splits less painful
Plug 'wesQ3/vim-windowswap'

" Hyperfocus
Plug 'junegunn/limelight.vim'

" Ninja like buffer juggling
Plug 'jeetsukumaran/vim-buffergator'

" For when you are too lazy to type for movement
Plug 'easymotion/vim-easymotion'

" I am one lazy ass dude
Plug '907th/vim-auto-save'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" General plugin enhancer
Plug 'tpope/vim-repeat'

" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'

" Git gutter
Plug 'airblade/vim-gitgutter'

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

" TODO
" let g:ncm2_pyclang#library_path = '/usr/lib/llvm-7/lib/libclang.so.1'
"let g:ncm2_pyclang#database_path = [
"            \ 'compile_commands.json']

" show full tag hierarchy in statusbar
let g:airline#extensions#tagbar#flags = ''
" let g:airline#extensions#tagbar#flags = 'f'
" theme in statusbar
let g:airline_theme='base16_monokai'
let g:airline#extensions#tabline#enabled = 0

" Set Goyo dimensions to my preference
let g:goyo_height = "100%"
let g:goyo_width = 120

" Make RipGrep highlight the matches
let g:rg_highlight = "true"

" Make NERDCommenter comment out empty lines; helps when
" commenting blocks and to make commented blocks stand
" out better
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" Configure theming
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
color vim-monokai-tasty
set background=dark

" Help Limelight use gruvbox
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Enable autosave
let g:auto_save = 1
" Save when changing a file in normal mode or leaving insert mode
let g:auto_save_events = ["InsertLeave", "TextChanged"]
" Save all files when autosaving (autosaving just one feels strange to me ;) )
let g:auto_save_write_all_buffers = 1

" Markdown-Preview.nvim
" Open in Chromium (Firefox's pdf export sucks)
let g:mkdp_browser='chromium'

" NERDTree
" Regexes to ignore (e.g. I don't need object files)
let g:NERDTreeIgnore = ['\.o$','\.a$','\.so$']

" 

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
nmap <leader>N :NERDTree<CR>

" Tagbar
nmap <leader>tb :TagbarOpenAutoClose<CR>

" Limelight
nmap <leader>l :Limelight!!<CR>

" Goyo
nmap <leader>g :Goyo<CR>

" Ncm2 completion menu with Tab
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make my preffered folding method less acrobatic
:nnoremap <leader>f zf%
:nnoremap <leader>o zo

" Use <leader><delete_key> to delete sth. without putting it in a buffer for pasting
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
vnoremap <leader>x "_x

" Open a fuzzy searchable command window
nnoremap <leader>c :Commands<CR>

" Get the current filename without the extension to the clipboard
nnoremap <leader>f :call CopyFileBasename()<CR>

" ALE maps
nnoremap <leader>ag :ALE
nnoremap <leader>ad :ALEGoToDefinition<CR>
nnoremap <leader>av :ALEGoToDefinition -vsplit<CR>
nnoremap <leader>ax :ALEGoToDefinition -split<CR>
nnoremap <leader>ar :ALEFindReferences<CR>
nnoremap <leader>as :ALESymbolSearch 
nnoremap <leader>ai :ALEImport<CR>
nnoremap <C-Space>  :ALEComplete<CR>
nnoremap <leader>at :ALEGoToTypeDefinition<CR>
nnoremap <leader>ap :ALEPrevious<CR>
nnoremap <leader>an :ALENext<CR>
nnoremap <leader>al :ALEDetail<CR>
nnoremap <leader>at :ALEToggle<CR>

" _K_ill all buffers, but don't close (neo)vim
nnoremap <leader>k :%bd<CR>

""""""""""""""""""""""""""""""""
" Functions and Automatics
""""""""""""""""""""""""""""""""
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 3/4)<CR>

" jump to the previous function
nnoremap <silent> [f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
nnoremap <silent> ]f :call
\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>

function CopyFileBasename()
	" Get filename without extension; this can later be used for searching
	" things. E.g. i have file.c open and want so search for file.h
	let foo = expand('%:r')
	" Copy this stuff to system clipboard
	call setreg('+', foo)
endfunction

" ToDo highlight on steroids
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|BUG|TRACE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

