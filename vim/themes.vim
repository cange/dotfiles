" == define colorscheme ========================================================
"
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

set background=dark

" set nighfox sub theme
colorscheme terafox
