let g:paredit_leader = maplocalleader
let g:paredit_electric_return = 0

nnoremap <localleader>ee :ConjureEval<CR>
nnoremap <localleader>eb :ConjureEvalBuf<CR>
nnoremap <localleader>d  :ConjureDocWord<CR>
nnoremap <localleader>lb :ConjureLogBuf<CR>
nnoremap <localleader>lt :ConjureLogToggle<CR>
nnoremap <localleader>.  :call<space>PareditMoveRight()<CR>
nnoremap <localleader>,  :call<space>PareditMoveLeft()<CR>
nnoremap <localleader>cc :ConjureConnect<Space>
nnoremap <localleader>cs :ConjureShadowSelect<Space>
