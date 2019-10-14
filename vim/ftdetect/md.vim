" force *.md as MarkDown, https://github.com/tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

let g:markdown_fenced_languages = ['html', 'json', 'python', 'scss', 'sh', 'sql', 'yaml']

" https://github.com/previm/previm 
nnoremap <silent> <leader>pv :PrevimOpen<CR>
