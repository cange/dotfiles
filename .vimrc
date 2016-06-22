if filereadable(expand('~/dotfiles/vimrc/vundle.vim'))
  source ~/dotfiles/vimrc/vundle.vim
endif

if filereadable(expand('~/dotfiles/vimrc/local'))
  source ~/dotfiles/vimrc/local
endif

if filereadable(expand('~/dotfiles/vimrc/generals.vim'))
  source ~/dotfiles/vimrc/generals.vim
endif

if filereadable(expand('~/dotfiles/vimrc/syntastic.vim'))
  source ~/dotfiles/vimrc/syntastic.vim
endif

if filereadable(expand('~/dotfiles/vimrc/themes.vim'))
  source ~/dotfiles/vimrc/themes.vim
endif

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
  autocmd FileType html,jsp,haml,slim,ruby,eruby,yaml,feature,java :call WideSetting()

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
map <leader>r :NERDTreeFind<CR>
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
"set clipboard=unnamedplus
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
  \ 'dir':  '\v[\/]\.(git|hg|svn|)|sass-cache|coverage$',
  \ 'file': '\v\.(scssc)$'
  \ }


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


set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
