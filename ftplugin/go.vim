autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
nnoremap <localleader>gs :lua require('go').setup()<CR>
