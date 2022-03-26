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

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins {{{
call plug#begin()
if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'folke/tokyonight.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'numToStr/Comment.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'ellisonleao/glow.nvim'
  " nvim-cmp {{{
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  " }}}
  " LSP {{{
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'onsails/lspkind-nvim'
  Plug 'simrat39/symbols-outline.nvim'
  " Snippets {{{
  Plug 'hrsh7th/vim-vsnip'
  Plug 'rafamadriz/friendly-snippets'
  " }}}
  " }}}
  " Telescope {{{
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
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
Plug 'editorconfig/editorconfig-vim'
Plug 'embear/vim-localvimrc'
Plug 'hashivim/vim-terraform'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-swap'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'css' ] }
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'pearofducks/ansible-vim'
Plug 'psliwka/vim-smoothie'
Plug 'romgrk/nvim-treesitter-context'
Plug 'ryanoasis/vim-devicons'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tyru/open-browser.vim'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'
Plug 'w0rp/ale'
" fern {{{
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-bookmark.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
" }}}
" fzf.vim {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" }}}
" Color schemes {{{
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'fenetikm/falcon'
Plug 'haishanh/night-owl.vim'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
" }}}
" Ctags {{{
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" }}}
" Git {{{
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rhubarb'
" }}}
" JavaScript {{{
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
" }}}
" Snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}
" Tmux {{{
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
" Plugin: fern-bokmark.vim {{{
nnoremap <leader>fb :Fern bookmark:///<cr>
" }}}
" Plugin: fern-renderer-nerdfont.vim {{{
let g:fern#renderer = "nerdfont"
" }}}
" Plugin: fzf.vim {{{
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <localleader>s  :Snippets<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}
" Plugin: indentLine {{{
let g:indentLine_faster     = 1
let g:indentLine_setConceal = 0
" }}}
" ListToggle {{{
let g:lt_location_list_toggle_map = '<leader>tl'
let g:lt_quickfix_list_toggle_map = '<leader>tq'
" }}}
" Plugin: open-browser.vim {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
" symbols-outline.nvim {{{
nnoremap <leader>ts :SymbolsOutline<cr>
" }}}
" Plugin: tagbar {{{
nmap <leader>tt :TagbarToggle<CR>
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
" Plugin: telescope.nvim {{{
nnoremap <localleader>,  :Telescope builtin<CR>
nnoremap <localleader>fb :Telescope file_browser<CR>
nnoremap <leader>ff      :Telescope file_browser path=%:p:h <CR>

nnoremap <leader>.       :Telescope resume<CR>
nnoremap <leader>/       :Telescope search_history<CR>
nnoremap <leader><space> :Telescope find_files find_command=fd,--color,never,--type,f,--hidden,--follow,--exclude,.git<CR>
nnoremap <leader>bb      :Telescope buffers<CR>
nnoremap <leader>bc      :Telescope git_bcommits<CR>
nnoremap <leader>bl      :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>bt      :Telescope current_buffer_tags<CR>
nnoremap <leader>cl      :Telescope colorscheme<CR>
nnoremap <leader>cm      :Telescope commands<CR>
nnoremap <leader>fr      :Telescope oldfiles<CR>
nnoremap <leader>ft      :Telescope filetypes<CR>
nnoremap <leader>gf      :Telescope git_files<CR>
nnoremap <leader>gs      :Telescope git_status<CR>
nnoremap <leader>km      :Telescope keymaps<CR>
nnoremap <leader>m       :Telescope marks<CR>
nnoremap <leader>sp      :Telescope live_grep<CR>
nnoremap <localleader>ht :Telescope help_tags<CR>
nnoremap <localleader>tt :Telescope tags<CR>
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
nnoremap <leader>tu :UndotreeToggle<cr>
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
" Plugin: vim-expand-region {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}}
" Plugin: vim-fugitive {{{
nmap <leader>gb :Git blame<cr>
nmap <leader>gl :Glog %<cr>
nmap <leader>gg :Git<cr>
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
" Plugin: vim-vsnip {{{
" https://github.com/hrsh7th/vim-vsnip#2-setting
if has('nvim')
  " Expand or jump
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
endif
" }}}
" Plugin: vim-swap {{{
let g:swap_no_default_key_mappings = 1

nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap <localleader>gs <Plug>(swap-interactive)
xmap <localleader>gs <Plug>(swap-interactive)
" }}}
" Plugin: vim-tmux-navigator {{{
let g:tmux_navigator_disable_when_zoomed = 1
" }}}
" Autocommands {{{1
augroup autoSaveAndRead " {{{2
  autocmd!
  autocmd TextChanged,InsertLeave,FocusLost * silent! wall
  autocmd CursorHold * silent! checktime
augroup END " }}} 2
if has('nvim')
  augroup highlightOnYank " {{{2
    autocmd!
    autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
  augroup END " }}} 2
endif
" }}}1
" Neovim-specific {{{
if has('nvim')
  set inccommand=split
  set pumblend=20

  " Treesitter playground {{{
  nnoremap <leader>ph :TSHighlightCapturesUnderCursor<CR>
  nnoremap <leader>tp :TSPlaygroundToggle<CR>
  " }}}

  lua require('Comment').setup()

  lua require('gitsigns_nvim')
  lua require('nvim_cmp')
  lua require('lsp_config')
  lua require('telescope_nvim')
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
