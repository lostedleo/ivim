""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/bundles.vim

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
set mouse=v                     " use mouse in all modes
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
"set matchpairs+=<:>            " specially for html

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
nmap tt :%s/\t/  /g<CR>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" eggcache vim
nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------
" CTags
"--------------------------------------------
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Auto_Open=0
let Tlist_Show_One_File = 1                    " only show current file's tags
let Tlist_Sort_Type = " name"                  " sort by name
let Tlist_Use_Right_Window = 0                 " show tags in right window
let Tlist_Compart_Format = 1                   " use compress
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0             " not close other file's tags
let Tlist_Enable_Fold_Column = 0               " not show fold tree

set tags=
set autochdir
nmap tl :Tlist<cr>
map tu :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>

" Auto load tags in current and parent's tags
function! s:CheckAndAddTagFile(path)
  if stridx(a:path, '/') == (strlen(a:path) - 1)
    let l:tags = a:path . 'tags'
  else
    let l:tags = a:path . '/tags'
  endif

  if stridx(&tags, l:tags) != -1
    echo l:tags "already added"
    return
  endif

  if !filereadable(l:tags)
    "echo l:tags "not readable"
    return
  endif

  let &tags =  len(&tags) == 0 ? l:tags : &tags . ',' . l:tags
  "echo l:tags "added"

  unlet! l:tags
endfunction

function! s:StrEndWith(str, pattern)
  if strridx(a:str, a:pattern) == strlen(a:str) - strlen(a:pattern)
    return 1
  else
    return 0
  endif
endfunction

function! s:SplitPath(path)
  let l:start = 0
  let l:list = []

  while 1 == 1
    let l:idx = stridx(a:path, '/', l:start)
    let l:start = l:idx + 1

    if l:idx == -1
      break
    endif

    let l:part = a:path[0:(l:idx > 0 ? l:idx - 1 : l:idx)]
    call add(l:list, l:part)
  endwhile

  if !s:StrEndWith(a:path, '/')
    call add(l:list, a:path)
  endif

  return l:list
endfunction

function! AddTagsInCwdPath()
  let l:cwd = tr(expand('%:p:h'), '\', '/')

  let l:pathes = s:SplitPath(l:cwd)

  for p in l:pathes
    call s:CheckAndAddTagFile(p)
  endfor

endfunction

" Auto load tags
"call AddTagsInCwdPath()
"--------------------------------------------
" Cscope
"--------------------------------------------
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb

  "nmap g<C-]> :cs find 3 <C-R>=expand(“<cword>”)<CR><CR>
  nmap g<C-/> :cs find 0 <C-R>=expand(“<cword>”)<CR><CR>

  nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

  nmap <Leader>f :Ack <C-R>=expand("<cword>")<CR><CR>

  map <silent> tc :call MakeCscope()<CR><CR><CR>

  func! MakeCscope()
    exec "!find . -name \"*.h\" -o -name \"*.c\" -o -name \"*.cpp\" -o -name \"*.cc\" > cscope.files"
    exec "!cscope -Rbqk -i ./cscope.files"
  endfunc
endif

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
let g:vimgdb_debug_file = ""
run bundle/vimgdb-for-vim7.3/vimgdb_runtime/macros/gdb_mappings.vim
nmap <silent> tb :bel 20vsplit gdb-variables<cr>

"--------------------------------------------
" Tagbar
"--------------------------------------------
let g:tagbar_left=1
"let g:tagbar_right=1
let g:tagbar_width=30
"let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1

"--------------------------------------------
" Nerd Tree
"--------------------------------------------
let NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=30
let NERDTreeWinPos = "right"

autocmd vimenter * call CallPlugin()
" Close vim when only Nerdtree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

func! CallPlugin()
  if !argc()
    exec "NERDTree"
    exec "Tagbar"
  elseif &filetype == 'c' || &filetype == 'cpp'
    exec "Tagbar"
  endif
endfunc

"--------------------------------------------
" SrcExpl
"--------------------------------------------
if ExistPlugin("SrcExpl")
  " The switch of the Source Explorer
  nmap <silent> ts :SrcExplToggle<CR>
  " Set the height of Source Explorer window
  let g:SrcExpl_winHeight = 8
  " Set 100 ms for refreshing the Source Explorer
  let g:SrcExpl_refreshTime = 100
  " Set "Enter" key to jump into the exact definition context
  let g:SrcExpl_jumpKey = "<ENTER>"
  " Set "Space" key for back from the definition context
  let g:SrcExpl_gobackKey = "<SPACE>"
  " In order to avoid conflicts, the Source Explorer should know what plugins
  " except itself are using buffers. And you need add their buffer names into
  " below listaccording to the command ":buffers!"
  let g:SrcExpl_pluginList = [
    \ "__Tagbar__",
    \ "NERD_tree_1",
    \ "[BufExplorer]",
    \ "Source_Explorer"
    \ ]

  " Enable/Disable the local definition searching, and note that this is not
  " guaranteed to work, the Source Explorer doesn't check the syntax for now.
  " It only searches for a match with the keyword according to command 'gd'
  let g:SrcExpl_searchLocalDef = 1
  " Do not let the Source Explorer update the tags file when opening
  let g:SrcExpl_isUpdateTags = 0
  " Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
  " create/update the tags file
  let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
endif

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
  nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

  let g:ycm_global_ycm_extra_conf = ''
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_key_invoke_completion='<C-;>'
  set completeopt=longest,menu
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
  let g:ycm_enable_diagnostic_signs = 0
  let g:ycm_enable_diagnostic_highlighting = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 0
  let g:ycm_complete_in_comments = 0
  let g:ycm_complete_in_strings = 0
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
nmap <silent> <F9> <ESC>:Tlist<RETURN>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nmap tg :TagbarToggle<cr>
nmap th :BufExplorer<CR>
nmap <F3> :NERDTreeToggle<cr>
imap <F3> <ESC> :NERDTreeToggle<CR>
nmap <F4> :IndentGuidesToggle<cr>
nmap <F6> :GundoToggle<cr>

" Delete blank line
nnoremap <C-F2> :g/^\s*$/d<CR>
"nmap th \be
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"

nmap  <D-/> :
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
nmap <C-F5> :call CompileRunGcc()<CR>
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

map <F8> :call Rungdb()<CR>
func! Rungdb()
  exec "w"
  exec "!g++ % -g -o %<"
  exec "!gdb ./%<"
endfunc

" Code format
map <C-F6> :call FormartSrc()<CR><CR>
func FormartSrc()
  exec "w"
  if &filetype == 'c'
    exec "!astyle --style=ansi -a --suffix=none %"
  elseif &filetype == 'cpp' || &filetype == 'hpp'
    exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
  elseif &filetype == 'perl'
    exec "!astyle --style=gnu --suffix=none %"
  elseif &filetype == 'py'||&filetype == 'python'
    exec "r !autopep8 -i --aggressive %"
  elseif &filetype == 'java'
    exec "!astyle --style=java --suffix=none %"
  elseif &filetype == 'jsp'
    exec "!astyle --style=gnu --suffix=none %"
  elseif &filetype == 'xml'
    exec "!astyle --style=gnu --suffix=none %"
  else
    exec "normal gg=G"
    return
  endif
  exec "e! %"
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
    call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
    call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
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
