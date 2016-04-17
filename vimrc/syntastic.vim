"
" == Syntastic-specific config settings ========================================
" automatically open the location list when a buffer has errors
if &diff
  " In vimdiff Mode do not auto-show the errors
  " let g:syntastic_auto_loc_list = 2
else
  let g:syntastic_auto_loc_list = 1
endif

" use signs to indicate lines with errors
" only if signs are available
" if has('signs')
   " let g:syntastic_enable_signs = 1
" endif
"
" always show warnings
let g:syntastic_quiet_messages = { 'level': 'warnings' }
let g:syntastic_javascript_jslint_quiet_messages = { 'level' : [] }
"
" No Check for HTML
" let g:syntastic_disabled_filetypes = ['html']
"

" disable enoying syntastic error highlighter
" let loaded_scss_syntax_checker = 1
" let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
" let g:syntastic_scss_checkers = ['scss_lint']
