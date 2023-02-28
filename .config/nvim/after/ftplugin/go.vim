nmap <leader>db <ESC>:Dispatch go build<cr>
nmap <leader>dr <ESC>:Dispatch go run %<cr>
nmap <leader>dt <ESC>:Dispatch go test<cr>

autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)
