"
" == Syntastic-specific config settings ========================================
" automatically open the location list when a buffer has errors

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if &diff
  " In vimdiff Mode do not auto-show the errors
  " let g:syntastic_auto_loc_list = 2
else
  let g:syntastic_auto_loc_list = 1
endif

" always show warnings
let g:syntastic_quiet_messages = { 'level': 'warnings' }
let g:syntastic_javascript_jslint_quiet_messages = { 'level' : [] }
"
" No Check for HTML
" let g:syntastic_disabled_filetypes = ['html']
"
let g:syntastic_javascript_checkers = ['eslint']
