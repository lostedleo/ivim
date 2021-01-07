""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Define functions check plugin exist or not in vundle
let g:bundle_path = $HOME . "/.vim/bundle"
function! s:GetPluginPath(name)
  let l:plugin_path = g:bundle_path . "/" . a:name
  return l:plugin_path
endfunction

function! ExistPlugin(name)
  if isdirectory(s:GetPluginPath(a:name))
    return 1
  else
    return 0
  endif
endfunction

if isdirectory(g:bundle_path)
  source ~/.vim/bundles.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Base Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim color config
color torte
" color desert
" color molokai
" color xemacs
" color solarized
" set background=light
" highlight clear
" let g:solarized_termcolors=256
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype dectection and ft specific plugin/indent
filetype plugin indent on

" Enable syntax hightlight and completion
syntax enable
syntax on

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1,big5
" Search config
set ignorecase
set smartcase
set incsearch
set hlsearch
"set highlight                  " conflict with highlight current line

" Editor settings
set cul                         " highlight cursor line
set cuc
set shortmess=atI               " not show Uganda children's tips
set go=                         " not graphics button
set nocompatible                " ignore VI consistency model
set history=10000               " set history numbers
set nofoldenable                " disable folding"
set confirm                     " prompt when existing from an unsaved file
set backspace=indent,eol,start  " More powerful backspacing
set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors
set mouse=i                     " use mouse in all modes
set report=0                    " always report number of lines changed
set nowrap                      " dont wrap lines
set scrolloff=5                 " 5 lines above/below cursor when scrolling
set number                      " show line numbers
set showmatch                   " show matching bracket (briefly jump)
set showcmd                     " show typed command in status bar
set wildmenu                    " vim self commonad intelligent completion
set title                       " show file in titlebar
set laststatus=2                " use 2 lines for the status bar
set matchtime=2                 " show matching bracket for 0.2 seconds
" Default Indentation
set autoindent
set smartindent                 " indent when
set tabstop=2                   " tab width
set softtabstop=2               " backspace
set shiftwidth=2                " indent width
set textwidth=120
set smarttab
set expandtab                   " expand tab to space
" set relativenumber
" set matchpairs+=<:>            " specially for html

set noeb                        " remove input error prompt sound
set autoread                    " auto load file when modified
set completeopt=preview,menu    " code completion
set autowrite                   " auto save file
set magic                       " set magic
set guioptions-=T               " hide tool bar
set guioptions-=m               " hide menu bar
set confirm                     " set confirm when handling not saved or readonly file
set nobackup
set noswapfile                  " no temp file
set whichwrap+=<,>,h,l          " allow backspace and cursor keys to cross line boundaries
" Allow use mouse in buffer
set selection=exclusive
set selectmode=mouse,key
"set fillchars=vert:\ ,stl:\ ,stlnc:\

" Replace the tab as spaces
nmap tt :%s/\t/  /g<cr>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" eggcache vim
inoremap jj <esc>
nnoremap ; :
nnoremap gs :shell<cr>
:command W w

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------
" nerdcommenter
"--------------------------------------------
if ExistPlugin("nerdcommenter")
  " Create default mappings
  let g:NERDCreateDefaultMappings = 1
  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims = 1
  " Use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs = 1
  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = 'left'
  " Set a language to use its alternate delimiters by default
  let g:NERDAltDelims_java = 1
  " Add your own custom formats or override the defaults
  let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
  " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDCommentEmptyLines = 1
  " Enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace = 1
  " Enable NERDCommenterToggle to check all selected lines is commented or not
  let g:NERDToggleCheckAllLines = 1
endif

let g:ackprg = 'ag --nogroup --nocolor --column'
nmap <Leader>f :Ack <C-R>=expand("<cword>")<cr><cr>
"--------------------------------------------
" tabbar
"--------------------------------------------
if ExistPlugin("tabbar")
  let g:Tb_MaxSize = 2
  let g:Tb_TabWrap = 1

  hi Tb_Normal guifg=white ctermfg=white
  hi Tb_Changed guifg=blue ctermfg=white
  hi Tb_VisibleNormal ctermbg=blue ctermfg=white
  hi Tb_VisibleChanged guifg=white ctermbg=blue ctermfg=white

  nmap <silent> <leader>h :Tbbp<cr>
  nmap <silent> <leader>l :Tbbn<cr>
  nmap <silent> <leader>d :Tbbd<cr>
endif

"--------------------------------------------
" easy-motion
"--------------------------------------------
let g:EasyMotion_leader_key = '<Leader>'

"--------------------------------------------
" vimgdb-motion
"--------------------------------------------
nmap <silent> tb :bel 20vsplit gdb-variables<cr>

"--------------------------------------------
" tagbar
"--------------------------------------------
if ExistPlugin("tagbar")
  let g:tagbar_left=1
  "let g:tagbar_right=1
  let g:tagbar_width=30
  "let g:tagbar_autofocus = 1
  let g:tagbar_sort = 0
  let g:tagbar_compact = 1

  autocmd vimenter * call CallPlugin()
  func! CallPlugin()
    exec "Tagbar"
  endfunc
endif

"--------------------------------------------
" Nerd Tree
"--------------------------------------------
let NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=30
let NERDTreeWinPos = "right"

" Close vim when only Nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"--------------------------------------------
" ZenCoding
"--------------------------------------------
let g:user_emmet_expandabbr_key='<C-j>'

"--------------------------------------------
" powerline
"--------------------------------------------
"let g:Powerline_symbols = 'fancy'

"--------------------------------------------
" YouCompleteMe
"--------------------------------------------
if ExistPlugin("YouCompleteMe")
  nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>

  let g:ycm_global_ycm_extra_conf = ''
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_key_invoke_completion='<C-;>'
  set completeopt=longest,menu
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
  let g:ycm_enable_diagnostic_signs = 1
  let g:ycm_enable_diagnostic_highlighting = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_complete_in_comments = 1
  let g:ycm_complete_in_strings = 1
  let g:ycm_min_num_of_chars_for_completion = 2
  let g:ycm_key_list_select_completion = ['<TAB>','<Down>']
endif

"--------------------------------------------
" NeoComplCache
"--------------------------------------------
if ExistPlugin("neocomplcache")
  let g:neocomplcache_enable_at_startup=1
  let g:neoComplcache_disableautocomplete=1
  "let g:neocomplcache_enable_underbar_completion = 1
  "let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_smart_case=1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  set completeopt-=preview

  imap <Leader> <C-k> <Plug>(neocomplcache_snippets_force_expand)
  smap <Leader> <C-k> <Plug>(neocomplcache_snippets_force_expand)
  imap <Leader> <C-l> <Plug>(neocomplcache_snippets_force_jump)
  smap <Leader> <C-l> <Plug>(neocomplcache_snippets_force_jump)

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType c setlocal omnifunc=ccomplete#Complete
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.erlang = '[a-zA-Z]\|:'
endif

"--------------------------------------------
" snipmate
"--------------------------------------------
imap <C-\> <Plug>snipMateNextOrTrigger
smap <C-\> <Plug>snipMateNextOrTrigger

imap <expr> <C-\> pumvisible()?  '<esc>a<Plug>snipMateNextOrTrigger':'<Plug>snipMateNextOrTrigger'
smap <C-\> <Plug>snipMateNextOrTrigger

"--------------------------------------------
" SuperTab
"--------------------------------------------
if ExistPlugin("SuperTab")
  let g:SuperTabDefaultCompletionType = '<c-x><c-u>'
  let g:SuperTabContextDefaultCompletionType = "<c-n>"
endif

"--------------------------------------------
" ctrlp
"--------------------------------------------
" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
nmap tp :CtrlP<cr>

"--------------------------------------------
" syntastic
"--------------------------------------------
if ExistPlugin("syntastic")
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcut
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------
" Fn config
"--------------------------------------------
" Keybindings for plugin toggle
nmap tg :TagbarToggle<cr>
nmap th :BufExplorer<cr>
nmap to :GundoToggle<cr>

" Delete blank line
nnoremap <C-F2> :g/^\s*$/d<cr>
"nmap th \be
:autocmd BufRead,BufNewFile *.dot map <F5> :w<cr>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <cr><cr> && exec "redr!"

nmap <D-/> :
nnoremap <leader>a :Ack
nnoremap <leader>v V`]
nnoremap <Leader>r :source ~/.vimrc<cr>
nnoremap te :NERDTreeToggle<cr>

map! <C-Z> <Esc>zzi
map! <C-O> <C-Y>,
map <C-A> ggVG$"+y
" Ctrl+c for paste in selected state
"map <C-v> "*pa
"imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$
vmap <C-c> "+y

" For quickfix next error
nnoremap <C-n> :cn<cr>

" F5 for Complite
nmap <leader>c :call CompileRunGcc()<cr>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    exec "!time python2.7 %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
  elseif &filetype == 'mkd'
    exec "!~/.vim/markdown.pl % > %.html &"
    exec "!firefox %.html &"
  endif
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Practical setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------
" Usefull Functions
"--------------------------------------------
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
  \ if ! exists("g:leave_my_cursor_position_alone") |
  \   if line("'\"") > 0 && line ("'\"") <= line("$") |
  \     exe "normal g'\"" |
  \   endif |
  \ endif

" for golang
let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" New file's Title
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for .c,.h,.sh,.java file
autocmd BufNewFile *.cc,*.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
func SetTitle()
  if &filetype == 'sh'
    call setline(1,"\#!/bin/bash")
    call append(line("."), "")
  elseif &filetype == 'python'
    call setline(1,"#!/usr/bin/env python")
    call append(line("."),"# coding=utf-8")
    call append(line(".")+1, "")

  elseif &filetype == 'ruby'
    call setline(1,"#!/usr/bin/env ruby")
    call append(line("."),"# encoding: utf-8")
    call append(line(".")+1, "")

  elseif &filetype == 'mkd'
    call setline(1,"<head><meta charset=\"UTF-8\"></head>")
  else
    call setline(1, "/*************************************************************************")
    call append(line("."), "  > File Name:    ".expand("%"))
    call append(line(".")+1, "  > Author:       Zhu Zhenwei")
    call append(line(".")+2, "  > Mail:         losted.leo@gmail.com")
    call append(line(".")+3, "  > Created Time: ".strftime("%c"))
    call append(line(".")+4, " ************************************************************************/")
    call append(line(".")+5, "")
  endif
  if expand("%:e") == 'cpp'
    call append(line(".")+6, "#include<iostream>")
    call append(line(".")+7, "using namespace std;")
    call append(line(".")+8, "")
  endif
  if &filetype == 'c'
    call append(line(".")+6, "#include<stdio.h>")
    call append(line(".")+7, "")
  endif
  if expand("%:e") == 'h'
    call append(line(".")+6, "#ifndef ".toupper(expand("%:r"))."_H_")
    call append(line(".")+7, "#define ".toupper(expand("%:r"))."_H_")
    call append(line(".")+8, "#endif")
  endif
  if &filetype == 'java'
    call append(line(".")+6,"public class ".expand("%:r"))
    call append(line(".")+7,"")
  endif
endfunc
autocmd BufNewFile * normal G

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++ Coding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter BUILD set filetype=python
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

function! FindProjectRootDir()
  let rootfile = findfile("BLADE_ROOT", ".;")
  " in project root dir
  if rootfile == "BLADE_ROOT"
    return "."
  endif
  return substitute(rootfile, "/BLADE_ROOT$", "", "")
endfunction
function! AutoSetPath()
  if exists("b:did_auto_set_path")
    return
  endif
  let b:did_auto_set_path = 1

  let l:project_root = FindProjectRootDir()
  if l:project_root != ""
    if l:project_root == "."
      exec "set path+=" . getcwd() . "/.build/pb/c++"
    else
      exec "set path+=" . project_root
      exec "set path+=" . project_root . "/.build/pb/c++"
    endif

    " use current path makefile first
    if filereadable("./Makefile") || filereadable("./makefile")
      return
    endif

    exec "set makeprg=make\\ -C\\ " . project_root
  endif
endfunction
call AutoSetPath()
