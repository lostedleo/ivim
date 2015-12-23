""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/bundles.vim

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" enable filetype dectection and ft specific plugin/indent
filetype plugin indent on

" enable syntax hightlight and completion
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim基本配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------
" Vim UI
"--------
" color desert     " 设置背景主题
color torte     " 设置背景主题
" color molokai     " 设置背景主题
"color xemacs " 设置背景主题

" set background=dark
set cul             "高亮光标所在行
set cuc
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
set go=             " 不要图形按钮
set nocompatible    "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限

" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" search
set incsearch
"set highlight   " conflict with highlight current line
set ignorecase
set smartcase
"将tab替换为空格
nmap tt :%s/\t/  /g<CR>

" editor settings
set history=10000
set nocompatible
set nofoldenable                                                  " disable folding"
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set mouse=v                                                       " use mouse in all modes
set report=0                                                      " always report number of lines changed                "
set nowrap                                                        " dont wrap lines
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
"set matchpairs+=<:>                                               " specially for html
" set relativenumber

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=2       " tab width
set softtabstop=2   " backspace
set shiftwidth=2    " indent width
" set textwidth=79
set smarttab
set expandtab       " expand tab to space

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FileType
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict

autocmd FileType c,cpp,php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" syntax support
autocmd Syntax javascript set syntax=jquery   " JQuery syntax support
" js
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow parentheses for Lisp and variants
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
let g:rbpt_max = 16
autocmd Syntax lisp,scheme,clojure,racket RainbowParenthesesToggle

"----------------------------------------------------------
" CTags配置
"----------------------------------------------------------
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
"默认打开Taglist
let Tlist_Auto_Open=0
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Sort_Type = "name"    " 按照名称排序
let Tlist_Use_Right_Window = 0  " 在右侧显示窗口
let Tlist_Compart_Format = 1    " 压缩方式
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags
"let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
"
set autochdir
nmap tl :Tlist<cr>
map tu :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR><CR>
"设置tags
set tags=

if has("cstag")
  if filereadable("*tags")
    set tags=tags,*tags
  endif
endif

"----------------------------------------------------------
" Cscope配置
"----------------------------------------------------------
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
endif

nmap g<C-]> :cs find 3 <C-R>=expand(“<cword>”)<CR><CR>
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

"----------------------------------------------------------
" tabbar
"----------------------------------------------------------
let g:Tb_MaxSize = 2
let g:Tb_TabWrap = 1

hi Tb_Normal guifg=white ctermfg=white
hi Tb_Changed guifg=blue ctermfg=white
hi Tb_VisibleNormal ctermbg=blue ctermfg=white
hi Tb_VisibleChanged guifg=white ctermbg=blue ctermfg=white

nmap <silent> <leader>h :Tbbp<cr>
nmap <silent> <leader>l :Tbbn<cr>
nmap <silent> <leader>d :Tbbd<cr>

"----------------------------------------------------------
" easy-motion
"----------------------------------------------------------
let g:EasyMotion_leader_key = '<Leader>'

"----------------------------------------------------------
" vimgdb-motion
"----------------------------------------------------------
let g:vimgdb_debug_file = ""
run bundle/vimgdb-for-vim7.3/vimgdb_runtime/macros/gdb_mappings.vim
nmap <silent> tb :bel 20vsplit gdb-variables<cr>

"----------------------------------------------------------
" Tagbar
"----------------------------------------------------------
let g:tagbar_left=1
"let g:tagbar_right=1
let g:tagbar_width=30
"let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
" tag for coffee
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }

  let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'sort' : 0,
        \ 'kinds' : [
        \ 'h:sections'
        \ ]
        \ }
endif

"----------------------------------------------------------
" Nerd Tree
"----------------------------------------------------------
let NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=30
let NERDTreeWinPos = "right"

"当打开vim且没有文件时自动打开NERDTree & Tagbar,否则只打开Tagbar
autocmd vimenter * call CallPlugin()
" 只剩 NERDTree时自动关闭
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

func! CallPlugin()
  if !argc()
    exec "NERDTree"
    exec "Tagbar"
  elseif &filetype == 'c' || &filetype == 'cpp'
    exec "NERDTree"
    exec "Tagbar"
    exec "SrcExpl"
  endif
endfunc
"----------------------------------------------------------
" SrcExpl
"----------------------------------------------------------
" // The switch of the Source Explorer
nmap <silent> ts :SrcExplToggle<CR>
" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8
" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100
" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"
" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [
      \ "__Tagbar__",
      \ "NERD_tree_1",
      \ "[BufExplorer]",
      \ "Source_Explorer"
      \ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1
" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" " // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

"----------------------------------------------------------
" ZenCoding
"----------------------------------------------------------
let g:user_emmet_expandabbr_key='<C-j>'

"----------------------------------------------------------
" powerline
"----------------------------------------------------------
"let g:Powerline_symbols = 'fancy'

"----------------------------------------------------------
" NeoComplCache
"----------------------------------------------------------
let g:neocomplcache_enable_at_startup=1
let g:neoComplcache_disableautocomplete=1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

imap <C-k> <Plug>(neocomplcache_snippets_force_expand)
smap <C-k> <Plug>(neocomplcache_snippets_force_expand)
imap <C-l> <Plug>(neocomplcache_snippets_force_jump)
smap <C-l> <Plug>(neocomplcache_snippets_force_jump)

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

"----------------------------------------------------------
" SuperTab
"----------------------------------------------------------
" let g:SuperTabDefultCompletionType='context'
let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
let g:SuperTabRetainCompletionType=2

"----------------------------------------------------------
" ctrlp
"----------------------------------------------------------
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
nmap tp :CtrlP<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"----------------------------------------------------------
" Fn config
"----------------------------------------------------------
" Keybindings for plugin toggle
nmap <silent> <F9> <ESC>:Tlist<RETURN>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nmap tg :TagbarToggle<cr>
nmap th :BufExplorer<CR>
nmap <F3> :NERDTreeToggle<cr>
imap <F3> <ESC> :NERDTreeToggle<CR>
nmap <F6> :GundoToggle<cr>
nmap <F4> :IndentGuidesToggle<cr>
"map <F12> gg=G

"去空行
nnoremap <C-F2> :g/^\s*$/d<CR>
"打开树状文件目录
"nmap th \be
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
"比较文件
nnoremap <C-F4> :vert diffsplit

nmap  <D-/> :
nnoremap <leader>a :Ack
nnoremap <leader>v V`]
nnoremap <Leader>r :source ~/.vimrc<cr>
nnoremap te :NERDTreeToggle<cr>

map! <C-Z> <Esc>zzi
map! <C-O> <C-Y>,
map <C-A> ggVG$"+y
" 选中状态下 Ctrl+c 复制
"map <C-v> "*pa
"imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$
vmap <C-c> "+y

"for quickfix next error

nnoremap <C-n> :cn<cr>

"C，C++ 按F5编译运行
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
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
  exec "w"
  exec "!g++ % -g -o %<"
  exec "!gdb ./%<"
endfunc

"代码格式优化化
map <C-F6> :call FormartSrc()<CR><CR>
"定义FormartSrc()
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
"结束定义FormartSrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif
"------------------
" Useful Functions
"------------------
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
set completeopt=preview,menu
"自动保存
set autowrite
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" sublime key bindings
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv

" eggcache vim
nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa

" for macvim
if has("gui_running")
  set go=aAce  " remove toolbar
  "set transparency=30
  set guifont=Monaco:h13
  set showtabline=2
  set columns=140
  set lines=40
  noremap <D-M-Left> :tabprevious<cr>
  noremap <D-M-Right> :tabnext<cr>
  map <D-1> 1gt
  map <D-2> 2gt
  map <D-3> 3gt
  map <D-4> 4gt
  map <D-5> 5gt
  map <D-6> 6gt
  map <D-7> 7gt
  map <D-8> 8gt
  map <D-9> 9gt
  map <D-0> :tablast<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
  "如果文件类型为.sh文件
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
  "新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G

