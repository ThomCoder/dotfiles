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
if executable("nodejs") != 1
  echo "nodejs not found in path; CoC.nvim not functional"
endif

" Airline status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

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

" Comment helper
Plug 'scrooloose/nerdcommenter'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'arzg/vim-colors-xcode'

" Make moving splits less painful
Plug 'wesQ3/vim-windowswap'

" Ninja like buffer juggling
Plug 'jeetsukumaran/vim-buffergator'

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

" I have no need for the error and warning sections of airline
let g:airline_section_error = ''
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

" COC.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WARNING: Huge copy pasted block ahead!
" This block has in its entirety been straight copy pasted from: https://github.com/neoclide/coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Open a fuzzy searchable command window
nnoremap <leader>C :Commands<CR>

" Get the current filename without the extension to the clipboard
nnoremap <leader>f :call CopyFileBasename()<CR>

" _K_ill all buffers, but don't close (neo)vim
nnoremap <leader>k :%bd<CR>

" Toggle render from better-whitespace
nnoremap <leader>w :ToggleWhitespace<CR>

" Move between vim tabs more easily
nnoremap <A-n> :tabnext<CR>
nnoremap <A-p> :tabprevious<CR>

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
" syn match MyTodo contained "\<\(FIXME|NOTE|TODO|BUG|TRACE|XXX):"
" hi def link MyTodo Todo

""""""""""""""""""""""""""""""""
" Final touches
" Some stuff just has to be
" written at the end for Vim to
" function properly.
""""""""""""""""""""""""""""""""
hi CursorLine   cterm=NONE ctermbg=Black ctermfg=NONE guibg=darkred guifg=white
