" plugins {{{

call plug#begin('~/.config/nvim/plugged')

"{{ dev }}
    Plug 'luochen1990/rainbow'
"{{ lsp }}
    Plug 'neovim/nvim-lspconfig'
"{{ rust dev }}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"{{ fime management }}
    Plug 'scrooloose/nerdtree'
"{{ ui }}
    Plug 'dracula/vim'
    Plug 'itchyny/lightline.vim'

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

autocmd FileType nerdtree nmap l <Enter>

" }}}

" luochen1990/rainbow {{{

let g:rainbow_active = 1

" }}}

" colors {{{

syntax enable
filetype plugin on
set termguicolors
set background=dark
colorscheme dracula

" }}}

" general {{{

set clipboard=unnamedplus
set nobackup
set noswapfile

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" }}}

" tabs {{{

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" }}}

" files {{{

set path+=**
set wildmenu
set wildmode=longest:full,full
set hidden

" }}}

" split {{{

set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H> 

" files {{{

set path+=**
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.git/*
set hidden

cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"

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

nnoremap S :%s//g<Left><Left>

"}}}

" ui {{{

set number
set relativenumber
set modelines=1
set showcmd
set cursorline
set showmatch
set signcolumn=yes
set updatetime=50
set shortmess+=c

" }}}

" remap {{{

:imap ii <Esc>

let mapleader = ","
let g:mapleader = ","

nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>d "+d

" }}}
