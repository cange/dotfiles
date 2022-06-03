" == define colorscheme ========================================================
"
if has("gui_running")
  set guioptions-=r                 " remove Right-hand scrollbar
else
  set t_Co=256
endif

" Important!!
if has('termguicolors')
  set termguicolors
endif
" For dark version.
set background=dark
" For light version.
"set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'hard'
" For better performance
let g:everforest_better_performance = 1
" apply themes
let g:airline_theme='everforest'
colorscheme everforest
