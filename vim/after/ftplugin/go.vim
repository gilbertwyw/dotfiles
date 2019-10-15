" writes the content of the file automatically if you call :make
set autowrite

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" vim-go {{{
" :GoSameIds, identifier highlighting
let g:go_auto_sameids        = 1

" :GoInfo, <Plug>(go-info)
let g:go_auto_type_info      = 1

" instead of invoking :GoImports manually
" might be slow on very large codebases
let g:go_fmt_command         = 'goimports'

let g:go_metalinter_autosave = 1

" mappings {{{2
" :GoBuild
nmap <leader>gob :<C-u>call <SID>build_go_files()<CR>
nmap <leader>gor <Plug>(go-run)
nmap <leader>got <Plug>(go-test)
" :GoCoverageToggle
nmap <Leader>goc <Plug>(go-coverage-toggle)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
" }}}2
" commands {{{2
" opens the alternate file
command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" }}}2
" highlight {{{2
" :h go-settings
let g:go_highlight_types             = 1
let g:go_highlight_fields            = 1
let g:go_highlight_functions         = 1
let g:go_highlight_function_calls    = 1
let g:go_highlight_operators         = 1
let g:go_highlight_extra_types       = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags     = 1
" }}}2
" }}}
" deoplete-go {{{
" https://github.com/deoplete-plugins/deoplete-go#sample-initvim
"
" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $HOME.'go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" }}}
" gotags {{{
" https://github.com/jstemmer/gotags#vim-tagbar-configuration
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
" }}}
