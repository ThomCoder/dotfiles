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

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

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
Plug 'neovim/nvim-lspconfig'

" Airline status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

" The fuzzy finder (also includes Ripgrep)
Plug 'junegunn/fzf'
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

" Comment helper
Plug 'scrooloose/nerdcommenter'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'arzg/vim-colors-xcode'

" Make moving splits less painful
Plug 'wesQ3/vim-windowswap'

" For when you are too lazy to type for movement
Plug 'easymotion/vim-easymotion'

" I am one lazy ass dude
Plug '907th/vim-auto-save'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" General plugin enhancer
Plug 'tpope/vim-repeat'

" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'

" Automatic handling of sessions
Plug 'tpope/vim-obsession'

" Debugging - yes in VIM!
Plug 'puremourning/vimspector'

" Advanced syntax tree generation
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

call plug#end()

""""""""""""""""""""""""""""""""
" Plugin Config
""""""""""""""""""""""""""""""""
" show full tag hierarchy in statusbar
let g:airline#extensions#tagbar#flags = ''
" theme in statusbar
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" airline unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" Display errors and warnings from ALE
let g:airline#extensions#ale#enabled = 1

" airline sections disabled
" let g:airline_section_error   (languageclient_error_count)
let g:airline_section_error = ''
" let g:airline_section_warning (languageclient_warning_count)
let g:airline_section_warning = ''

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
color xcodewwdc
set background=dark

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

" Vimspector (debugging tool)
let g:vimspector_enable_mappings = 'HUMAN'

" Tree-Sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
}
EOF

" Nvim-LSPconfig
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
EOF

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

" Tagbar
nmap <leader>tb :TagbarOpenAutoClose<CR>

" Goyo
nmap <leader>g :Goyo<CR>

" Make my preffered folding method less acrobatic
:nnoremap <leader>z zf%
:nnoremap <leader>o zo

" Use <leader><delete_key> to delete sth. without putting it in a buffer for pasting
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
vnoremap <leader>x "_x

" Get the current filename without the extension to the clipboard
nnoremap <leader>f :call CopyFileBasename()<CR>

" Nvim-LSPconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" _K_ill all buffers, but don't close (neo)vim
nnoremap <leader>k :%bd<CR>

" Toggle render from better-whitespace
nnoremap <leader>w :ToggleWhitespace<CR>

" Move between vim tabs more easily
nnoremap <A-n> :tabnext<CR>
nnoremap <A-p> :tabprevious<CR>

" Access open buffers with fzf.vim
nnoremap <leader>b :Buffers<CR>
" Open a fuzzy searchable command window with fzf.vim
nnoremap <leader>C :Commands<CR>
" Open a fuzzy searchable window showing all open buffers' lines with fzf.vim
nnoremap <leader>l :Lines<CR>
" Open a fuzzy searchable window showing all normal mode mappings with fzf.vim
nnoremap <leader>m :Maps<CR>

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
	let foo = expand('%:rt')
	let foo_list = split(foo, "/")
	let basename = foo_list[-1]
	" Copy this stuff to system clipboard
	call setreg('+', basename)
endfunction

" ToDo highlight on steroids
" syn match MyTodo contained "\<\(FIXME|NOTE|TODO|BUG|TRACE|XXX):"
" hi def link MyTodo Todo

""""""""""""""""""""""""""""""""
" Final touches
" Some stuff just has to be
" written at the end for Vim to
" function properly.
""""""""""""""""""""""""""""""""
hi CursorLine   cterm=NONE ctermbg=Black ctermfg=NONE guibg=darkred guifg=white
