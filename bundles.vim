set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"------------------
" Code Completions
"------------------
" Bundle 'ajh17/VimCompletesMe'
Bundle 'ycm-core/YouCompleteMe'
" Bundle 'Shougo/neocomplcache'
" Bundle 'mattn/emmet-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'

"------ snipmate dependencies -------
" snippets
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
" Bundle 'garbas/vim-snipmate'
" Bundle 'honza/vim-snippets'

"-----------------
" Fast navigation
"-----------------
" Bundle 'edsono/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'

"--------------
" Fast editing
"--------------
Bundle 'tpope/vim-surround'
Bundle 'preservim/nerdcommenter'
" Bundle 'sjl/gundo.vim'
" Bundle 'godlygeek/tabular'
" Bundle 'nathanaelkane/vim-indent-guides'

"--------------
" IDE features
"--------------
" Bundle 'fholgado/minibufexpl.vim'
" Bundle 'zhaocai/GoldenView.Vim'
Bundle 'preservim/nerdtree'
Bundle 'preservim/tagbar'
"Bundle 'wesleyche/SrcExpl'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'junegunn/fzf'

" git plugin
" Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'scrooloose/syntastic'
Bundle 'bronson/vim-trailing-whitespace'
" Bundle 'lostedleo/taglist'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'lostedleo/avim'
"Bundle 'lostedleo/vimgdb-for-vim7.3'

"-------------
" Other Utils
"-------------
" Bundle 'humiaozuzu/fcitx-status'
" Bundle 'nvie/vim-togglemouse'
Bundle 'rizzatti/dash.vim'

"----------------------------------------
" Syntax/Indent for language enhancement
"----------------------------------------
"------- web backend ---------
" Bundle '2072/PHP-Indenting-for-VIm'
"Bundle 'tpope/vim-rails'
" Bundle 'lepture/vim-jinja'
"Bundle 'digitaltoad/vim-jade'

"------- web frontend ----------
Bundle 'othree/html5.vim'
Bundle 'tpope/vim-haml'
" Bundle 'pangloss/vim-javascript'
" Bundle 'kchmck/vim-coffee-script'
" Bundle 'nono/jquery.vim'
" Bundle 'groenewege/vim-less'
" Bundle 'wavded/vim-stylus'
" Bundle 'nono/vim-handlebars'

"------- markup language -------
" Bundle 'tpope/vim-markdown'
" Bundle 'timcharper/textile.vim'

"------- Ruby --------
" Bundle 'tpope/vim-endwise'

"------- Go ----------
Bundle 'fatih/vim-go'

"------- FPs ------
" Bundle 'kien/rainbow_parentheses.vim'
" Bundle 'wlangstroth/vim-racket'
" Bundle 'vim-scripts/VimClojure'
" Bundle 'rosstimson/scala-vim-support'

"--------------
" Color Schemes
"--------------
Bundle 'rickharris/vim-blackboard'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rickharris/vim-monokai'
Bundle 'tpope/vim-vividchalk'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'fisadev/fisa-vim-colorscheme'

filetype plugin indent on     " required!
