set nocompatible                    " Use Vim settings, rather then Vi settings (much better!).
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required

" === Vim bundle setup =========================================================
Plugin 'godlygeek/tabular'                " Vim script for text filtering and alignment
Plugin 'ervandew/supertab'                " Supertab is a vim plugin which allows you to use <Tab> for all your insert completion needs (:help ins-completion).
Plugin 'duff/vim-bufonly'                 " plugin to unload all buffers but the current one.
Plugin 'ap/vim-css-color'                 " Highlighting multiple colors on the same line
Plugin 'tpope/vim-endwise'                " This is a simple plugin that helps to end certain structures automatically.
Plugin 'tpope/vim-fugitive'               " Git support in vim
Plugin 'tpope/vim-git'                    " Vim Git runtime files
Plugin 'airblade/vim-gitgutter'           " shows a git diff in the “gutter” (sign column)
Plugin 'suan/vim-instant-markdown'        " Want to instantly preview finnicky markdown files
Plugin 'maksimr/vim-jsbeautify'           " formated javascript file
Plugin 'tpope/vim-markdown'               " Vim Markdown runtime files
Plugin 'tpope/vim-pathogen'               " makes it super easy to install plugins and runtime files in their own private directories.
Plugin 'tpope/vim-ragtag'                 " ghetto HTML/XML mappings
Plugin 'nelstrom/vim-textobj-rubyblock'   " A custom text object for selecting ruby blocks.
Plugin 'kana/vim-textobj-user'            " Support for user-defined text objects
Plugin 'cange/vim-theme-bronkow'          " Theme: colorscheme for vim and powerline
Plugin 'guns/xterm-color-table.vim'       " color palette
Plugin 'editorconfig/editorconfig-vim'    " syntax helper
Plugin 'tpope/vim-repeat'                 " enable repeating supported plugin maps with “.”
Plugin 'tpope/vim-surround'               " is all about “surroundings”: parentheses, brackets, quotes, XML tags, and more
Plugin 'tpope/vim-unimpaired'             " bubble text lines
Plugin 'tpope/vim-abolish'                " easily search for, substitute, and abbreviate multiple variants of a word
Plugin 'matchit.zip'                      " highlight start and end node for markup and more
Plugin 'terryma/vim-multiple-cursors'     " adaption of Sublime Text’s awesome multiple selection
Plugin 'Gundo'                            " Vim plugin to visualize your Vim undo tree
" === VIM UI ===================================================================
Plugin 'Lokaltog/vim-powerline'           " status line
"" === VIM NAVIGATION ==========================================================
Plugin 'scrooloose/nerdtree'              " Navigation: Explore your filesystem and to open files and directories
Plugin 'tyok/ack.vim'                     " Navigation: Multiple file search :Ack [options] {pattern} [{directory}]
Plugin 'rking/ag.vim'                     " Navigation: A code searching tool similar to ack :Ag [options] {pattern} [{directory}]
Plugin 'tyok/nerdtree-ack'                " Navigation: make ack works on nerdtree[options] {pattern} [{directory}]
Plugin 'EvanDotPro/nerdtree-chmod'        " Navigation: This is a plugin for NERDTree to allow for chmod’ing files in Vim
Plugin 'kien/ctrlp.vim'                   " Navigation: Quick fuzzy search with Ctrl-P
" Plugin 'tomtom/tmru_vim'                  " Navigation: File manager by given buffer
" === SYNTAX HELPER ============================================================
Plugin 'Raimondi/delimitMate'             " Syntax helper: Automatic closing of quotes, brackets, etc.
Plugin 'garbas/vim-snipmate'              " Syntax helper: Provide support for textual snippets
Plugin 'tComment'                         " Syntax helper: basic comment functionality
Plugin 'scrooloose/nerdcommenter'         " Syntax helper: advanced comment functionality
Plugin 'rstacruz/sparkup'                 " Syntax helper: Markup helper div[class=foo]
" === SYNTAX LINTER ============================================================
Plugin 'walm/jshint.vim'                  " Syntax linter: JavaScript
Plugin 'ngmy/vim-rubocop'                 " Syntax linter: Ruby
Plugin 'scrooloose/syntastic'             " Syntax linter: Checks the syntax basically and displays any resulting errors
" === SYNTAX HIGHLIGHTING ======================================================
Plugin 'cange/scss-syntax.vim'            " Syntax highlighting: SCSS
Plugin 'digitaltoad/vim-jade'             " Syntax highlighting: Jade
Plugin 'elzr/vim-json'                    " Syntax highlighting: JSON
Plugin 'hail2u/vim-css3-syntax'           " Syntax highlighting: CSS
Plugin 'mustache/vim-mustache-handlebars' " Syntax highlighting: handlebars
Plugin 'pangloss/vim-javascript'          " Syntax highlighting: JavaScript
Plugin 'mxw/vim-jsx'                      " Syntax highlighting: ReactJS JSX
Plugin 'slim-template/vim-slim'           " Syntax highlighting: Slim
Plugin 'tpope/vim-haml'                   " Syntax highlighting: Haml
Plugin 'vim-less'                         " Syntax highlighting: Less
Plugin 'vim-ruby/vim-ruby'                " Syntax highlighting: Ruby
Plugin 'php.vim'                          " Syntax highlighting: PHP
" === DEPENDENCIES =============================================================
Plugin 'tlib'                             " Dependency for tmru_vim, snipMate
" Plugin 'tomtom/tlib_vim'                  " Dependency for tmru_vim, snipMate
Plugin 'MarcWeber/vim-addon-mw-utils'     " Dependency for snipMate
Plugin 'L9'                               " Dependency for ?

"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if filereadable(expand('~/vimrc/local'))
  source ~/vimrc/local
endif
"
syntax on
" == General setting ===========================================================

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
      autocmd GuiEnter * set guifont=Roboto\ Mono\ for\ Powerline:h16 columns=230 lines=80 number
    elseif s:uname == 'Linux'
      " 'Linux'
      autocmd GuiEnter * set guifont=DejaVu\ Sans\ Mono\ 12 columns=220 lines=70 number
    endif
  endif
augroup END
"
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

colorscheme bronkow
" ==============================================================================
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
" == global functions ==========================================================
" Remove trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! WideSetting()
  set colorcolumn=150             " highlight end of line
  set textwidth=150               " 150 character lines
endfunction

" enable everytime CSS autocompletion
function! CssSetting()
  filetype plugin on
  " map double tab as call
  " source ~/.vim/autoload/csscomplete.vim
  set omnifunc=csscomplete#CompleteCSS
  " let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
  " SuperTab option for context aware completion
  let g:SuperTabDefaultCompletionType = "context"
  imap <TAB><TAB> <C-X><C-O>
endfunction

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
      return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" command to open files with uncommitted changes
" https://github.com/garybernhardt/dotfiles/commit/86d12f24cd2301af99a2966f0dc9a082cdee2cb7
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git ls-files -m')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()
"
" == Only do this part when compiled with support for autocommands =============
if has("autocmd")
  " Enable file type detection
  filetype on
  " use a different value of Tabs and Spaces
  " autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab

  autocmd FileType css,scss,sass,stylus,less :call CssSetting()

  autocmd FileType tag, setlocal ft=jsp
  autocmd BufNewFile *.html,*.jsp,*.erb,*.haml,*.slim,*.rb,*.yml,*.feature,*.java :call WideSetting()

  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

  au BufRead,BufNewFile .bowerrc,.jshintrc,.jscsrc set filetype=json
  au BufRead,BufNewFile *.scss set filetype=scss
  " refresh the vimrc file after saving it
  autocmd BufWritePost .vimrc source ~/.vimrc
  " autocmd BufWritePost .vimrc.local source ~/.vimrc.local
endif " autocmd ================================================================
"
" == Indentation commands ======================================================
" Keep Block visually marked when indenting
nmap > ><CR>gv
nmap < <<CR>gv
vmap > ><CR>gv
vmap < <<CR>gv
" == Buffer management =========================================================
set hidden                          " hide confirmtion before switch to another
                                    " buffer file
" press F10 to open the buffer menu
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" pres F5 to open the Gundo menu
nnoremap <F5> :GundoToggle<CR>
"
" == custom shortcuts ==========================================================
"                                   " ,v for editing vimrc.local file
nmap <leader>v :tabedit ~/.vimrc.local<CR>
"
" == Text Bubbling - unimpaired ================================================
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
"
" == JavaScript section ========================================================
" au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" == Plugin's ==================================================================
" Change From Backslash to Comma in commands \a -> ,a
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" plugin: T-Comment                 - shortcut: ,c
map <leader>c <C-_><C-_>
" stop highlighting search results by click enter
map <CR> :nohlsearch <CR>
" plugin: NERDTree                  - shortcut: Ctrl+n
map <leader>e :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeDirArrows = 1
" Allow single click for directories
let NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 30
" ------------------------------------------------------------------------------
" Switch between the last two files - shortcut: ,,
nnoremap <leader><leader> <c-^>
" show the most recent files        - shortcut: ,m
map <leader>m :TRecentlyUsedFiles<CR>

" == Copy and Past Behavior ====================================================

" Visually select the text that was last edited/pasted
nmap gV `[v`]
" copy all text into the system clipboard
" set clipboard^=unnamedset
" set clipboard+=unnamed
" set clipboard=unnamedplus
set clipboard=unnamed

" Load plugins that ship with Vim
" This is a dependency for vim-textobj-rubyblock
runtime macros/matchit.vim
runtime ftplugin/man.vim

"
"
" TODO the part of below, have to refactor


" ctrlp settings
set runtimepath^=~/.vimbundles/ctrlp.vim

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|sass-cache$',
  \ 'file': '\v\.(scssc)$'
  \ }

set hls                     " highlight search


let g:Powerline_stl_path_style = 'short'

function! NumberToggle()
  if(&relativenumber == 1)
    set number             " Enable line numbers - incompatibly with relativenumber
  else
    set relativenumber     " current cursor position has always the count of 0
  endif
endfunc

nnoremap <leader>n :call NumberToggle()<cr>
" mapping for :W to write
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Some stuff for tabular
if exists(":Tabularize")
  nmap <leader>= :Tabularize /=<CR>
  vmap <leader>= :Tabularize /=<CR>
  nmap <leader>: :Tabularize /:\zs<CR>
  vmap <leader>: :Tabularize /:\zs<CR>
endif

noremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Syntastic-specific config settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" JavaScript settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" JSLINT
""""""""""
" Enalble jsLint
filetype plugin on
" Since we are going to invoke :make all the time, I’m going to bind it to F5.
" Step by step:
"   :w — save the file, doesn’t hurt if it’s already saved
"   :make — invoke make
"   :cw — open the quickfix window if there are errors. Close it if there are no errors.
" @link http://technotales.wordpress.com/2011/05/21/node-jslint-and-vim/

" JSbeautify setting
""""""""""""""""""""""
let s:opt_indent_char = "  "
