" == define colorscheme ========================================================
"
if has("gui_running")
  set guioptions-=r                 " remove Right-hand scrollbar
else
  set t_Co=256
endif

colorscheme bronkow

" nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
  \ 'Modified'  : '±',
  \ 'Staged'    : '✓',
  \ 'Untracked' : '✪',
  \ 'Renamed'   : '➲',
  \ 'Unmerged'  : '≈',
  \ 'Deleted'   : '×',
  \ 'Dirty'     : '⬌',
  \ 'Clean'     : '',
  \ 'Ignored'   : '☒',
  \ 'Unknown'   : '⍰'
  \ }

