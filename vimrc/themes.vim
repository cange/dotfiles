" == define colorscheme ========================================================
"
if has("gui_running")
  set guioptions-=r                 " remove Right-hand scrollbar
else
  set t_Co=256
endif
" == define cursor =============================================================
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;#FFFFFF\x7"
  " let &t_SI = "\<Esc>]12;#0087AF\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;#ABD300\x7"
  silent !echo -ne "\033]12;gray\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]gray\007"
  " use \003]12;gray\007 for gnome-terminal
endif

colorscheme bronkow_material
" ==============================================================================
