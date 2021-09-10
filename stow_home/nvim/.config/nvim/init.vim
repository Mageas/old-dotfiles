" plugins {{{

call plug#begin('~/.config/nvim/plugged')

"{{ The Basics }}
    Plug 'itchyny/lightline.vim'                       " Lightline statusbar
"{{ File management }}
    Plug 'scrooloose/nerdtree'                         " Nerdtree
"{{ Theme }}
    Plug 'dracula/vim'                                 " Dracula

call plug#end()

" }}}

" itchyny/lightline.vim {{{

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly'], [ 'filename' ] ],
      \   'right': [ [ 'percent', 'lineinfo' ], [ 'fileencoding', 'fileformat' ] ],
      \ },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component': {
      \   'fileencoding': ' %{&fenc!=#""?&fenc:&enc}',
      \   'fileformat': '[%{&ff}] ',
      \   'percent': ' %p%%',
      \   'lineinfo': ' %l:%c',
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ 'component_expand': {
      \   'readonly': 'LightLineReadOnly',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'percent': 'raw',
      \   'fileencoding': 'raw',
      \   'fileformat': 'raw',
      \ },
      \ }

function! LightlineFilename()
  let modified = &modified ? '[+]' : ''
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:] . modified
  endif
  return expand('%') . modified
endfunction

function! LightLineReadOnly()
  return &readonly ? 'RO' : ''
endfunction

set laststatus=2
set noshowmode

" }}}

" scrooloose/nerdtree {{{

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

" }}}

" colors {{{

syntax enable
filetype plugin on
set termguicolors
set background=dark
colorscheme dracula

" }}}

" general{{{

set clipboard=unnamedplus
set nobackup
set noswapfile

" }}}

" tabs {{{

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" }}}

" find {{{

set path+=**
set wildmenu
set wildignore+=**/node_modules/** 
set hidden

" }}}

" search {{{

set incsearch
set nohlsearch

set scrolloff=10

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"}}}

" ui {{{

let mapleader=","
set number
set relativenumber
set modelines=1
set showcmd
set cursorline
set showmatch
set cmdheight=2
set signcolumn=yes
set updatetime=50
set shortmess+=c

" }}}

" remap {{{

:imap ii <Esc>
map <Space> <Leader>

" }}}
