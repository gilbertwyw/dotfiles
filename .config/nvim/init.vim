let s:darwin = has('mac')

set nocompatible
" otherwise NERDTree shows strange character instead of arrows
set encoding=utf-8
scriptencoding utf-8

set cursorline

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

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

" True color {{{
" : CTRL-v + ESC
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
" }}}
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
" jk is escape
inoremap jk <Esc>

" make last typed word uppercase
inoremap <Plug>UpCase <Esc>hgUaweA
imap ;u <Plug>UpCase
" }}}2
" Normal {{{2
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

" Learn the following 2 from Damian Conway
" 1) exchange 'S' for:
nmap  S  :%s//g<LEFT><LEFT>
" 2) exchange 'M' for:
" nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'

" add filetype
nnoremap gaf :set ft+=.

nnoremap S :%s//g<Left><Left>

if s:darwin
  " try to open the current file in default application
  nnoremap <leader>o :silent !open '%'<cr>
endif
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
" vim-plug {{{
command! PU PlugUpdate | PlugUpgrade

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'Valloric/MatchTagAlways', { 'for': ['xml', 'html'] }
Plug 'Valloric/ListToggle'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'bling/vim-airline'
Plug 'chrisbra/unicode.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'embear/vim-localvimrc'
Plug 'hashivim/vim-terraform'
Plug 'janko-m/vim-test'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-emoji'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/vim-slash'
Plug 'justinmk/vim-sneak'
Plug 'kannokanno/previm'
Plug 'keith/investigate.vim'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-swap'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'css' ] }
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
Plug 'othree/html5.vim', { 'for': [ 'html', 'svg' ] }
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'terryma/vim-expand-region'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tyru/open-browser.vim'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'voldikss/vim-floaterm'
Plug 'wellle/targets.vim'
Plug 'w0rp/ale'
" deoplete.nvim {{{
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" }}}
" LSP {{{ 
Plug 'prabirshrestha/vim-lsp'
" configuration
Plug 'mattn/vim-lsp-settings'
" autocompletion
Plug 'lighttiger2505/deoplete-vim-lsp'
" }}}
" fzf.vim {{{
" Use installed 'fzf' from Homebrew
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" }}}
" Color schemes {{{
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/Spacegray.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'cocopon/iceberg.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'haishanh/night-owl.vim'
Plug 'junegunn/seoul256.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'mhartington/oceanic-next'
Plug 'nanotech/jellybeans.vim'
Plug 'rakr/vim-one'
" }}}
" Ctags {{{
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" }}}
" Git {{{
Plug 'airblade/vim-gitgutter'
Plug 'low-ghost/nerdtree-fugitive'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rhubarb'
Plug 'Xuyuanp/nerdtree-git-plugin'
" }}}
" Languages {{{
" CSS {{{
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
" }}}
" Go {{{
Plug 'arp242/gopher.vim'
" }}}
" JavaScript {{{
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}
Plug 'mvolkmann/vim-js-arrow-function', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" requires 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
" }}}
" }}}
" Snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}
" Tmux {{{
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'wellle/tmux-complete.vim'
" }}}
call plug#end()
" }}}
" Plugin: ale {{{
" https://github.com/w0rp/ale#5ii-how-can-i-keep-the-sign-gutter-open
let g:ale_sign_column_always   = 1
" https://github.com/w0rp/ale#5vii-how-can-i-change-the-format-for-echo-messages
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
" https://github.com/w0rp/ale#5ix-how-can-i-navigate-between-errors-quickly
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)
nmap <silent> ]W <Plug>(ale_last)
" }}}
" Plugin: deoplete.nvim {{{
" https://github.com/Shougo/deoplete.nvim#installation
let g:deoplete#enable_at_startup = 1
" }}}
" Plugin: editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }}}
" Plugin: FixCursorHold.nvim {{{
" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100
" }}}
" Plugin: fzf.vim {{{
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <leader>bb      :Buffers<CR>
nnoremap <leader>bc      :BCommits<CR>
nnoremap <leader>bl      :BLines<CR>
nnoremap <leader>bt      :BTags<CR>
nnoremap <leader>cl      :Colors<CR>
nnoremap <leader>cm      :Commands<CR>
nnoremap <leader><Space> :Files<CR>
" files under same directory
nnoremap <Leader>ff      :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <leader>ft      :Filetypes<CR>
nnoremap <leader>gf      :GFiles?<CR>
nnoremap <leader>gF      :GFiles<CR>
nnoremap <leader>m       :Marks<CR>
nnoremap <localleader>ht :Helptags<CR>
nnoremap <localleader>s  :Snippets<CR>
nnoremap <localleader>tt :Tags<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}
" Plugin: indentLine {{{
let g:indentLine_faster     = 1
let g:indentLine_setConceal = 0
" }}}
" Plugin: investigate.vim {{{
if s:darwin
  let g:investigate_use_dash=1
endif
" }}}
" Plugin: nerdtree {{{
augroup nerdtree
  autocmd!
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeMinimalUI        = 1
  let g:NERDTreeHijackNetrw    = 0
  map <silent> <leader>nn :NERDTreeToggle<CR> :NERDTreeMirror<CR>
  map <silent> <leader>nf :NERDTreeFind<CR>
  " open a NERDTree automatically when vim starts up if no files were specified
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
" }}}
" Plugin: open-browser.vim {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
" Plugin: tagbar {{{
nmap <localleader>tb :TagbarToggle<CR>
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" }}}
" Plugin: tmux-complete.vim {{{
" https://github.com/wellle/tmux-complete.vim#settings
let g:tmuxcomplete#trigger = ''
" }}}
" Plugin: tmuxline.vim {{{
let g:tmuxline_theme = 'airline'
let g:tmuxline_powerline_separators = 0
" }}}
" Plugin: UltiSnips {{{
set rtp+=~/dotfiles/vim/
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir='~/dotfiles/vim/snips/'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']
" }}}
" Plugin: undotree {{{
nnoremap <F5> :UndotreeToggle<cr>
" }}}
" Plugin: vim-airline {{{
" make symbols look okay
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" }}}
" Plugin: vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gaa <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gaa <Plug>(EasyAlign)
" }}}
" Plugin: vim-emoji {{{
" trigger by CTRL-X CTRL-U in INSERT mode with terminal vim
" Using Emojis as Git Gutter symbols, work only with terminal vim(?)
silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif
" }}}
" Plugin: vim-expand-region {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}}
" Plugin: vim-floaterm {{{
let g:floaterm_keymap_new    = '<localleader>ff'
let g:floaterm_keymap_next   = '<localleader>fn'
let g:floaterm_keymap_prev   = '<localleader>fp'
let g:floaterm_keymap_toggle = '<localleader>ft'

nnoremap <localleader>fs :FloatermSend<Space>
" }}}
" Plugin: vim-fugitive {{{
nmap <leader>gb :Gblame<cr>
nmap <leader>gl :Glog %<cr>
nmap <leader>gs :Gstatus<cr>
" }}}
" Plugin: vim-grepper {{{
if executable('rg')
  " -highlight does not work when passing extra option(s) 
  " https://github.com/mhinz/vim-grepper/wiki/Using-the-commands
  nnoremap <leader>ss :Grepper -tool rg -highlight<cr>
  nnoremap <leader>sb :Grepper -tool rg -buffers -highlight<cr>
  " Search for the word under the cursor
  nnoremap <Leader>sw :Grepper -tool rg -cword -noprompt<cr>
endif
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
" }}}
" Plugin: vim-localvimrc {{{
" https://github.com/embear/vim-localvimrc#the-glocalvimrc_persistent-setting
let g:localvimrc_persistent=1
" }}}
" Plugin: vim-lsp {{{
let g:lsp_highlight_references_enabled = 1

function! s:on_lsp_buffer_enabled() abort
  " setlocal omnifunc=lsp#complete
  " setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd              <plug>(lsp-definition)
  nmap <buffer> K               <plug>(lsp-hover)
  nmap <buffer> <localleader>gi <plug>(lsp-implementation)
  nmap <buffer> ]g              <Plug>(lsp-next-diagnostic)
  nmap <buffer> [g              <Plug>(lsp-previous-diagnostic)
  nmap <buffer> <localleader>gr <plug>(lsp-references)
  nmap <buffer> <f2>            <plug>(lsp-rename)
  nmap <buffer> <localleader>gt <plug>(lsp-type-definition)
endfunction
augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" }}}
" Plugin: vim-hexokinase {{{
nnoremap <leader>ct :HexokinaseToggle<CR>
" }}}
" Plugin: vim-sneak {{{
let g:sneak#s_next = 1
let g:sneak#label  = 1
" These mappings do not invoke label-mode
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" }}}
" Plugin: vim-slash {{{
noremap <plug>(slash-after) zz
" }}}
" Plugin: vim-slime {{{
let g:slime_target = 'tmux'
" }}}
" Plugin: vim-swap {{{
let g:swap_no_default_key_mappings = 1

nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap <localleader>gs <Plug>(swap-interactive)
xmap <localleader>gs <Plug>(swap-interactive)
" }}}
" Plugin: vim-test {{{
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" }}}
" Plugin: vim-tmux-navigator {{{
let g:tmux_navigator_disable_when_zoomed = 1
" }}}
" Plugin: vimux {{{
" horizontal is vertical here
let g:VimuxOrientation = 'h'
" in percentage
let g:VimuxHeight = '40'
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
" }}}
" Autocommands {{{1
augroup autoSaveAndRead " {{{2
  autocmd!
  autocmd TextChanged,InsertLeave,FocusLost * silent! wall
  autocmd CursorHold * silent! checktime
augroup END " }}} 2
" }}}1
" Neovim-specific {{{
if has('nvim')
  set inccommand=split
  set pumblend=20
endif
" }}}
