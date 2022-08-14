" https://github.com/junegunn/vim-plug
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
" === Vim bundle setup =========================================================
Plug 'airblade/vim-gitgutter'           " shows a git diff in the “gutter” (sign column)
Plug 'Xuyuanp/nerdtree-git-plugin'      " A plugin of NERDTree showing git status flags
Plug 'preservim/nerdtree'               " Enable vim-devicons
Plug 'ap/vim-css-color'                 " Highlighting multiple colors on the same line
Plug 'cange/vim-theme-bronkow'          " Theme: colorscheme for vim and powerline
Plug 'EdenEast/nightfox.nvim'           " Theme: colorscheme for vim and powerline
Plug 'duff/vim-bufonly'                 " plugin to unload all buffers but the current one.
Plug 'editorconfig/editorconfig-vim'    " syntax helper
Plug 'ervandew/supertab'                " Supertab is a vim plugin which allows you to use <Tab> for all your insert completion needs (:help ins-completion).
Plug 'godlygeek/tabular'                " Vim script for text filtering and alignment
Plug 'guns/xterm-color-table.vim'       " color palette
Plug 'kana/vim-textobj-user'            " Support for user-defined text objects
Plug 'maksimr/vim-jsbeautify'           " formated javascript file
Plug 'https://github.com/adelarsq/vim-matchit' " highlight start and end node for markup and more
Plug 'nelstrom/vim-textobj-rubyblock'   " A custom text object for selecting ruby blocks.
Plug 'suan/vim-instant-markdown'        " Want to instantly preview finnicky markdown files
Plug 'terryma/vim-multiple-cursors'     " adaption of Sublime Text’s awesome multiple selection
Plug 'tpope/vim-abolish'                " easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-endwise'                " This is a simple plugin that helps to end certain structures automatically.
Plug 'tpope/vim-fugitive'               " Git support in vim
Plug 'tpope/vim-git'                    " Vim Git runtime files
"Plug 'jreybert/vimagit'                 " Git client ¡ bug in nerdtree !
Plug 'tpope/vim-markdown'               " Vim Markdown runtime files
Plug 'tpope/vim-pathogen'               " makes it super easy to install plugins and runtime files in their own private directories.
Plug 'tpope/vim-ragtag'                 " ghetto HTML/XML mappings
Plug 'tpope/vim-repeat'                 " enable repeating supported plugin maps with “.”
Plug 'tpope/vim-surround'               " is all about “surroundings”: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-unimpaired'             " bubble text lines
" === VIM UI ===================================================================
Plug 'vim-airline/vim-airline'          " Lean & mean status/tabline for vim that’s light as air.
Plug 'vim-airline/vim-airline-themes'   " Themes for airline status line
Plug 'kristijanhusak/vim-hybrid-material' " Material design
"" === VIM NAVIGATION ==========================================================
" Plug 'EvanDotPro/nerdtree-chmod'        " Navigation: This is a plugin for NERDTree to allow for chmod’ing files in Vim
Plug 'kien/ctrlp.vim'                   " Navigation: Quick fuzzy search with Ctrl-P
Plug 'majutsushi/tagbar'                " Navigation: provides an easy way to browse the tags of the current file
Plug 'rking/ag.vim'                     " Navigation: A code searching tool similar to ack :Ag [options] {pattern} [{directory}]
Plug 'scrooloose/nerdtree'              " Navigation: Explore your filesystem and to open files and directories
Plug 'tyok/ack.vim'                     " Navigation: Multiple file search :Ack [options] {pattern} [{directory}]
Plug 'tyok/nerdtree-ack'                " Navigation: make ack works on nerdtree[options] {pattern} [{directory}]
Plug 'RRethy/vim-illuminate'            " Navigation: selectively illuminating other uses of current word under the cursor
" === SYNTAX HELPER ============================================================
Plug 'Raimondi/delimitMate'             " Syntax helper: Automatic closing of quotes, brackets, etc.
Plug 'scrooloose/nerdcommenter'         " Syntax helper: advanced comment functionality
Plug 'rstacruz/sparkup'                 " Syntax helper: Markup helper div[class=foo]
Plug 'othree/csscomplete.vim'           " Syntax helper: bult-in CSS complete function to latest CSS standard.
" === SYNTAX LINTER ============================================================
Plug 'ngmy/vim-rubocop'                 " Syntax linter: Ruby
Plug 'scrooloose/syntastic'             " Syntax linter: Checks the syntax basically and displays any resulting errors
" === SYNTAX HIGHLIGHTING ======================================================
Plug 'sheerun/vim-polyglot'             " Collection of language/syntax packs for Vim
Plug 'evanleck/vim-svelte', {'branch': 'main'} " Syntax highlighting: SVELTE
" === Very last loading plugs
Plug 'ryanoasis/vim-devicons'           " icons https://github.com/ryanoasis/vim-devicons


" Initialize plugin system
call plug#end()
