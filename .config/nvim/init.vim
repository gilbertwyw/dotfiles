
set nocompatible
set encoding=utf-8
scriptencoding utf-8

set cursorline

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" do not redraw screen in the middle of a macro
set lazyredraw

" enable hybrid line number mode
set relativenumber
set number

" more intuitive split
set splitbelow
set splitright

" turn off backup for now
set nobackup
set noswapfile

" change the terminal's title
set title

if (exists('+colorcolumn'))
  set colorcolumn=80
endif

" enable mouse in all modes
if has('mouse')
  set mouse=a
endif

" flashing instead of beeping
set visualbell

" instead of manually yank to '*' register
set clipboard+=unnamed

if has('persistent_undo')
  let s:undoDir = $HOME . '/.vim/undodir'
  if !isdirectory(s:undoDir)
    call mkdir(s:undoDir, '', 0700)
  endif
  let &undodir=s:undoDir
  set undofile
endif

let mapleader      = "\<Space>"
let maplocalleader = ','

" Indentation {{{
" use soft tab
set expandtab
" number of visual spaces per TAB
set tabstop=2
" number of space to use for autoindenting
set shiftwidth=2
" }}}
" Mappings {{{1
" Command-line {{{2
cmap w!! w !sudo tee > /dev/null %
" }}}2
" Insert {{{2
" undo break points
inoremap ! !<c-g>u
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u

" jk is escape
inoremap jk <Esc>

" mark at the point you are typing after leaving insert mode
inoremap ;1 <c-o>ma

" make last typed word uppercase
inoremap <Plug>UpCase <Esc>hgUaweA
imap ;u <Plug>UpCase
" }}}2
" Normal {{{2
" join line without moving the cursor
nnoremap J mzJ`z

" select whatever's just been pasted
nnoremap gV `[V`]

" move vertically by visual line
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" swap the jump keys
nnoremap ' `
nnoremap ` '

" Quickly edit/reload the vimrc file
nnoremap <leader>re :e $MYVIMRC<CR>
nnoremap <leader>rr :so $MYVIMRC<CR>

" Resize window
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

" Learn the following 2 from Damian Conway
" 1) exchange 'S' for:
nnoremap S :%s//g<Left><Left>
" 2) exchange 'M' for:
" nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'

" add filetype
nnoremap gaf :set ft+=.

" }}}2
" Visual {{{2
" http://vim-jp.org/blog/2015/06/30/visual-ctrl-a-ctrl-x.html
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

" Visual shifting (does not exit Visual mode)
vnoremap > >gv
vnoremap < <gv
" }}}2
" }}}1
" Search {{{
set hlsearch
set ignorecase
set smartcase
" }}}
" Plugin: fern.vim {{{
" https://github.com/lambdalisue/fern.vim/wiki/Tips#define-nerdtree-like-mappings
function! s:init_fern() abort
  " Define NERDTree like mappings
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  nmap <buffer> ma <Plug>(fern-action-new-path)
  nmap <buffer> P gg

  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  nmap <buffer> cd <Plug>(fern-action-cd)
  nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>

  nmap <buffer> I <Plug>(fern-action-hide-toggle)

  nmap <buffer> q :<C-u>quit<CR>
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
" }}}
" Autocommands {{{1
augroup packer_user_config " {{{2
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end " }}}2
augroup autoSaveAndRead " {{{2
  autocmd!
  autocmd TextChanged,InsertLeave,FocusLost * silent! wall
  autocmd CursorHold * silent! checktime
augroup END " }}} 2
augroup highlightOnYank " {{{2
  autocmd!
  autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
augroup END " }}} 2
" }}}1
" True color {{{
" : CTRL-v + ESC
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
" }}}
lua require('plugins')
