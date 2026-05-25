set nocompatible

filetype off
set noignorecase smartcase
set hidden hlsearch
set incsearch
set fileformat=unix
set title ttyfast
set textwidth=111
set sw=2 ts=2 sts=2 expandtab
set novisualbell noerrorbells
set smartindent
set showcmd number
set nowrap linebreak
set nocursorline
set splitbelow splitright

" Filetype handling
filetype plugin indent on

call plug#begin()

Plug 'dahu/SearchParty' " NOTE: remember to comment <c-l> mapping out of plugged/SearchParty/searchparty_user_maps.vim

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'ruanyl/vim-gh-line'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'tpope/vim-unimpaired'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-eunuch'
Plug 'diepm/vim-rest-console'
Plug 'vim-scripts/AnsiEsc.vim'


" colors
Plug 'mnishz/colorscheme-preview.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'romainl/Apprentice'

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set termguicolors
" set background=dark
" colorscheme gruvbox
" let g:airline_theme='gruvbox'

"""""""""""""""""""""""""""""""""""""""""""""
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

" This makes the time before it updates your hover faster
set updatetime=300
" Highlight the symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap keys for gotos
nmap gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

" Use `[d` and `]d` to navigate diagnostics
nmap <leader>q :CocList diagnostics<CR>
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap for autofix the problem under the cursor
nnoremap <silent> <leader>qf <Plug>(coc-fix-current)

" Remap for rename current word
nmap <leader>gn <Plug>(coc-rename)

" Use :OR to organize the imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use K to show documentation in floating window.
nnoremap <silent> K :call ShowDocumentation()<CR>
" Show hover when provider exists, fallback to vim's builtin behavior.
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('definitionHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Apply AutoFix to problem on the current line.
nmap <leader>cf <Plug>(coc-fix-current)
" Apply ESLink fix to the whole file
nmap <leader>fm :call CocAction('runCommand', 'eslint.executeAutofix')<CR>

" Open the files tree with the current file highlighted
nnoremap <leader>e :CocCommand explorer --reveal<CR>
"""""""""""""""""""""""""""""""""""""""""""""

" fzf
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fb :Buffers<CR>

" VRC
let g:vrc_trigger='<Leader>j'
let g:vrc_syntax_highlight_response=1
let g:vrc_curl_opts={
  \'--include': '',
  \'--location': '',
  \'--show-error': '',
  \'--silent': '',
  \ '-k': '',
  \}
let g:vrc_auto_format_response_enabled=1
let g:vrc_auto_format_response_patterns={ 'json': "jq --sort-keys '.'" }

" Mouse support
set mouse=a
set ttymouse=sgr
set balloonevalterm

map <ScrollWheelDown> <C-E>
map <ScrollWheelUp> <C-Y>

set wildignore+=*/.git/*,*/node_modules,*/build,*/target

set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/
