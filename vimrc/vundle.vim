set nocompatible              " Use Vim settings, rather then Vi settings (much better!).
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required

" === Vim bundle setup =========================================================
Plugin 'Gundo'                            " Vim plugin to visualize your Vim undo tree
Plugin 'airblade/vim-gitgutter'           " shows a git diff in the “gutter” (sign column)
Plugin 'ap/vim-css-color'                 " Highlighting multiple colors on the same line
Plugin 'cange/vim-theme-bronkow'          " Theme: colorscheme for vim and powerline
Plugin 'duff/vim-bufonly'                 " plugin to unload all buffers but the current one.
Plugin 'editorconfig/editorconfig-vim'    " syntax helper
Plugin 'ervandew/supertab'                " Supertab is a vim plugin which allows you to use <Tab> for all your insert completion needs (:help ins-completion).
Plugin 'godlygeek/tabular'                " Vim script for text filtering and alignment
Plugin 'guns/xterm-color-table.vim'       " color palette
Plugin 'kana/vim-textobj-user'            " Support for user-defined text objects
Plugin 'maksimr/vim-jsbeautify'           " formated javascript file
Plugin 'matchit.zip'                      " highlight start and end node for markup and more
Plugin 'nelstrom/vim-textobj-rubyblock'   " A custom text object for selecting ruby blocks.
Plugin 'suan/vim-instant-markdown'        " Want to instantly preview finnicky markdown files
Plugin 'terryma/vim-multiple-cursors'     " adaption of Sublime Text’s awesome multiple selection
Plugin 'tpope/vim-abolish'                " easily search for, substitute, and abbreviate multiple variants of a word
Plugin 'tpope/vim-endwise'                " This is a simple plugin that helps to end certain structures automatically.
Plugin 'tpope/vim-fugitive'               " Git support in vim
Plugin 'tpope/vim-git'                    " Vim Git runtime files
Plugin 'tpope/vim-markdown'               " Vim Markdown runtime files
Plugin 'tpope/vim-pathogen'               " makes it super easy to install plugins and runtime files in their own private directories.
Plugin 'tpope/vim-ragtag'                 " ghetto HTML/XML mappings
Plugin 'tpope/vim-repeat'                 " enable repeating supported plugin maps with “.”
Plugin 'tpope/vim-surround'               " is all about “surroundings”: parentheses, brackets, quotes, XML tags, and more
Plugin 'tpope/vim-unimpaired'             " bubble text lines
" === VIM UI ===================================================================
Plugin 'vim-airline/vim-airline'          " Lean & mean status/tabline for vim that’s light as air.
Plugin 'vim-airline/vim-airline-themes'   " Themes for airline status line
"" === VIM NAVIGATION ==========================================================
Plugin 'EvanDotPro/nerdtree-chmod'        " Navigation: This is a plugin for NERDTree to allow for chmod’ing files in Vim
Plugin 'kien/ctrlp.vim'                   " Navigation: Quick fuzzy search with Ctrl-P
Plugin 'majutsushi/tagbar'                " Navigation: provides an easy way to browse the tags of the current file
Plugin 'rking/ag.vim'                     " Navigation: A code searching tool similar to ack :Ag [options] {pattern} [{directory}]
Plugin 'scrooloose/nerdtree'              " Navigation: Explore your filesystem and to open files and directories
Plugin 'tyok/ack.vim'                     " Navigation: Multiple file search :Ack [options] {pattern} [{directory}]
Plugin 'tyok/nerdtree-ack'                " Navigation: make ack works on nerdtree[options] {pattern} [{directory}]
" === SYNTAX HELPER ============================================================
Plugin 'Raimondi/delimitMate'             " Syntax helper: Automatic closing of quotes, brackets, etc.
Plugin 'garbas/vim-snipmate'              " Syntax helper: Provide support for textual snippets
Plugin 'tComment'                         " Syntax helper: basic comment functionality
Plugin 'scrooloose/nerdcommenter'         " Syntax helper: advanced comment functionality
Plugin 'rstacruz/sparkup'                 " Syntax helper: Markup helper div[class=foo]
" === SYNTAX LINTER ============================================================
Plugin 'ngmy/vim-rubocop'                 " Syntax linter: Ruby
Plugin 'scrooloose/syntastic'             " Syntax linter: Checks the syntax basically and displays any resulting errors
Plugin 'walm/jshint.vim'                  " Syntax linter: JavaScript
" === SYNTAX HIGHLIGHTING ======================================================
Plugin 'cange/scss-syntax.vim'            " Syntax highlighting: SCSS
Plugin 'digitaltoad/vim-jade'             " Syntax highlighting: Jade
Plugin 'elzr/vim-json'                    " Syntax highlighting: JSON
Plugin 'hail2u/vim-css3-syntax'           " Syntax highlighting: CSS
Plugin 'mustache/vim-mustache-handlebars' " Syntax highlighting: handlebars
Plugin 'mxw/vim-jsx'                      " Syntax highlighting: ReactJS JSX
Plugin 'pangloss/vim-javascript'          " Syntax highlighting: JavaScript
Plugin 'php.vim'                          " Syntax highlighting: PHP
Plugin 'slim-template/vim-slim'           " Syntax highlighting: Slim
Plugin 'tpope/vim-haml'                   " Syntax highlighting: Haml
Plugin 'vim-less'                         " Syntax highlighting: Less
Plugin 'vim-ruby/vim-ruby'                " Syntax highlighting: Ruby
" === DEPENDENCIES =============================================================
Plugin 'L9'                               " Dependency for ?
Plugin 'MarcWeber/vim-addon-mw-utils'     " Dependency for snipMate
Plugin 'tlib'                             " Dependency for tmru_vim, snipMate

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
