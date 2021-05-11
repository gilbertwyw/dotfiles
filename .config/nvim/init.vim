let s:darwin = has('mac')

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
" jk is escape
inoremap jk <Esc>

" mark at the point you are typing after leaving insert mode
inoremap ;1 <c-o>ma

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
if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'folke/tokyonight.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
  " LSP {{{
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  " }}}
endif
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'Valloric/MatchTagAlways', { 'for': ['xml', 'html'] }
Plug 'Valloric/ListToggle'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'bling/vim-airline'
Plug 'chrisbra/unicode.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'embear/vim-localvimrc'
Plug 'hashivim/vim-terraform'
Plug 'janko-m/vim-test'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-emoji'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/vim-slash'
Plug 'justinmk/vim-sneak'
Plug 'kannokanno/previm'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-swap'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'css' ] }
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'othree/html5.vim', { 'for': [ 'html', 'svg' ] }
Plug 'psliwka/vim-smoothie'
Plug 'ryanoasis/vim-devicons'
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
" fern {{{
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
" }}}
" fzf.vim {{{
" Use installed 'fzf' from Homebrew
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" }}}
" Color schemes {{{
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/Spacegray.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'cocopon/iceberg.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'haishanh/night-owl.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'
" }}}
" Ctags {{{
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" }}}
" Git {{{
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rhubarb'
" }}}
" Languages {{{
" JavaScript {{{
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'mvolkmann/vim-js-arrow-function', { 'for': 'javascript' }
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
" }}}
call plug#end()
" }}}
" Plugin: ale {{{
let g:ale_disable_lsp = 1
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
" Plugin: completion-nvim {{{
if has('nvim')
  let g:completion_enable_snippet = 'UltiSnips'

  " https://github.com/nvim-lua/completion-nvim#recommended-setting
  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Set completeopt to have a better completion experience
  set completeopt=menuone,noinsert,noselect

  " Avoid showing message extra message when using completion
  set shortmess+=c

  autocmd BufEnter * lua require'completion'.on_attach()
endif
" }}}
" Plugin: editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }}}
" Plugin: FixCursorHold.nvim {{{
" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100
" }}}
" Plugin: fern.vim {{{
noremap <silent> <leader>fd :Fern . -drawer -reveal=% -toggle<CR>

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
" Plugin: fern-renderer-nerdfont.vim {{{
let g:fern#renderer = "nerdfont"
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
" Plugin: tokyonight.nvim {{{
let g:tokyonight_style = "night"
let g:tokyonight_sidebars = [ "qf", "terminal" ]
" }}}
" Plugin: UltiSnips {{{
set rtp+=~/dotfiles/vim/
let g:UltiSnipsExpandTrigger      = "<C-e>"
let g:UltiSnipsEditSplit          = 'vertical'
let g:UltiSnipsSnippetsDir        = '~/dotfiles/vim/snips/'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'snips']
" }}}
" Plugin: undotree {{{
nnoremap <F5> :UndotreeToggle<cr>
" }}}
" Plugin: vim-airline {{{
" make symbols look okay
let g:airline_powerline_fonts            = 1
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
nmap <leader>gb :Git blame<cr>
nmap <leader>gl :Glog %<cr>
nmap <leader>gs :Git<cr>
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

  lua require('lsp_config')
  lua require('treesitter')
endif
" }}}
" True color {{{
" : CTRL-v + ESC
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors

colorscheme tokyonight
" }}}
