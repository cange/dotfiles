"
" == General setting ===========================================================
syntax on
filetype plugin indent on
set guioptions-=m                   " remove menu bar
set guioptions-=T                   " remove toolbar
augroup vimrc
  autocmd!
  if has("unix")
    let s:uname=system("echo -n \"$(uname)\"")
    if s:uname == "Darwin"
      " Integrating of MacVim with rvm rubies
      set shell=/bin/sh
      " 'MacOS'
      autocmd GuiEnter * set guifont=Roboto\ Mono\ for\ Powerline:h12 columns=230 lines=80 number
    elseif s:uname == 'Linux'
      " 'Linux'
      autocmd GuiEnter * set guifont=DejaVu\ Sans\ Mono\ 12 columns=220 lines=70 number
    endif
  endif
augroup END
"
" == General Config ============================================================
set title                           " Update terminal window title
set visualbell                      " Turn off sounds
set showmode                        " Show the current mode
set showcmd                         " Show incomplete commands
set autoread                        " Reload files changed outside of vim
set ttyfast                         " Use a fast terminal connection
set ruler                           " Show the line and column number of the cursor position
set backspace=indent,eol,start      " Allow backspace in insert mode
set laststatus=2                    " Always show a status line
setglobal fileencoding=utf-8        " file should be UTF-8 endcoded be default
set encoding=utf-8                  " Default character encoding
set fileencodings=ucs-bom,utf-8,latin1
set cursorline                      " Highlight current line
set gdefault                        " Add the g flag to search/replace by default
" ==============================================================================
"
" == Indentation ===============================================================
set colorcolumn=80                  " highlight end of line
set textwidth=80                    " 80 character lines
set smartindent                     " Turn on smart indent
" == Tabs and Spaces ===========================================================
set tabstop=2                       " 1 tab == 4 spaces
set softtabstop=2                   " Make backspace remove spaces by shiftwith

set shiftwidth=2
set expandtab                       " Use spaces instead of tabs
set nosmarttab                      " Don't be smart when using tabs ;)
set nowrap                          " Wrap lines
" ==============================================================================
set mouse=a                         " Enable mouse in all modes

"
" == Show invisible characters =================================================
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:_
set list!                           " show by default invisible characters
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
"
" == Completion ================================================================
"
set wildmode=list:longest           " cange default: longest,list:full
set wildmenu                        " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~         " stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.psd
set wildignore+=*/tmp/*,*.scssc,*.so,*.swp,*.zip     " MacOSX/Linux
" ==============================================================================
"
" == Searching =================================================================
set ignorecase                      " Ignore case when searching
set smartcase                       " Don't ignore case if search contains upper-case characters
set gdefault                        " Substitude command (:s) always does global search
set incsearch                       " Find the next match as we type the search
set hlsearch                        " Highlight searches by default
" ==============================================================================
"
" == folding settings ==========================================================
set foldmethod=indent               " fold based on indent
set foldnestmax=10                  " deepest fold is 10 levels
set nofoldenable                    " dont fold by default
set foldlevel=10                    " this is just what i use
" ==============================================================================
"
" == Buffer ====================================================================
" see https://coderwall.com/p/sdhfug/vim-swap-backup-and-undo-files
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
" or disable
set noswapfile
set nobackup
