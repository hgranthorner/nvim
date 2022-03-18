autocmd BufWritePre *.go lua OrgImports(1000)
"autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
"autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

