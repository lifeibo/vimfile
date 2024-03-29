set nocompatible          "不要兼容vi
filetype off              "必须的设置：

command Hello :call


"Color Settings {
set background=dark          "使用color solarized
set ttyfast
set ruler
set backspace=indent,eol,start
colorscheme desert
"}

"tab setting {
set tabstop=4
set softtabstop=4
set expandtab   " tab as space
set shiftwidth=4
"}

set foldmethod=manual "set default foldmethod

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fenc=utf-8
set autoindent
set hidden
set cindent
set encoding=utf-8

set autowrite
"set laststatus=2
"set number                                    "显示行号
"set undofile                                  "无限undo
"set nowrap                                    "禁止自动换行
"autocmd! bufwritepost ~/.vimrc source %         "自动载入配置文件不需要重启
" 跳到上一次编译的位置
autocmd BufReadPost *
   \ if line("'\"") > 0 && line ("'\"") <= line("$") |
   \ exe "normal g'\"" |
   \ endif

autocmd BufNewFile,BufRead *.h,*.c setfiletype cpp

"自动换行
set wrap
"没有交换文件
set noswapfile

set ignorecase "设置大小写敏感和聪明感知(小写全搜，大写完全匹配)
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch

set whichwrap=b,s,<,>,[,]  "让退格，空格，上下箭头遇到行首行尾时自动移到下一行（包括insert模式）

"插入模式下移动
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-h> <left>

"===================================================
"修改leader键为逗号
let mapleader=","

"复制到系统剪切板
map<silent> <leader>y "+y
map<silent> <c-y> "+y

map <c-u> %


"修改vim的正则表达
"nnoremap / /\v
"vnoremap / /\v

"使用<leader>空格来取消搜索高亮
nnoremap <leader><space> :noh<cr>

"设置隐藏gvim的菜单和工具栏 F2切换
set guioptions-=m
set guioptions-=T
"去除左右两边的滚动条
set go-=r
set go-=L

" map my key
map <silent> <C-e> $
map <silent> <C-a> ^
map <C-n> <Esc>:make<cr>
map <c-h> <c-w>h
map <c-l> <c-w>l

map <c-u> %

"Vundle Settings {
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'matchit.zip'
Bundle 'Tabular'
Bundle 'trailing-whitespace'
Bundle "ayang/AutoComplPop"
Bundle "racer-rust/vim-racer"
Bundle "rust-lang/rust.vim"

Bundle 'The-NERD-tree'
  "设置相对行号
  nmap <leader>t :NERDTree<cr>
  let NERDTreeShowBookmarks=1
  let NERDTreeShowFiles=1
  let NERDTreeShowHidden=1
  let NERDTreeIgnore=['\.$','\~$']
  let NERDTreeShowLineNumbers=1
  let NERDTreeWinPos=1

Bundle "https://github.com/lifeibo/visualmark"
    " 设置快捷键
    if !hasmapto('<Plug>Vm_toggle_sign')
      map <silent> <unique> <c-k><c-k> <Plug>Vm_toggle_sign 
    endif
    nnoremap <silent> <script> <Plug>Vm_toggle_sign	:call Vm_toggle_sign()<cr>

    if !hasmapto('<Plug>Vm_goto_next_sign')
      map <unique> <c-k><c-n> <Plug>Vm_goto_next_sign
    endif
    nnoremap <silent> <script> <Plug>Vm_goto_next_sign	:call Vm_goto_next_sign()<cr>

    if !hasmapto('<Plug>Vm_goto_prev_sign')
      map <unique> <c-k><c-o> <Plug>Vm_goto_prev_sign
    endif
    nnoremap <silent> <script> <Plug>Vm_goto_prev_sign	:call Vm_goto_prev_sign()<cr>


Bundle "https://github.com/vim-scripts/a.vim"
Bundle "https://github.com/lifeibo/vimfile"
Bundle "https://github.com/vim-scripts/genutils"
"Bundle "https://github.com/ctrlpvim/ctrlp.vim"
"Bundle "tacahiroy/ctrlp-funky"
"CtrlP
"let g:ctrlp_map = '<c-p>'
"nmap <Leader>f :CtrlPMRUFiles<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$|code.google.com|bitbucket.org|gopkg.in|golang.org|darwin_amd64|linux_amd64|auto\/libs|portal\/data/|portal\/dave/',
"  \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg)$',
"  \ }

highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE


Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'
"<Leader>f在当前目录搜索文件
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <Leader>f :Files<CR>
"<Leader>b切换Buffer中的文件
nnoremap <silent> <Leader>b :Buffers<CR>
"<Leader>p在当前所有加载的Buffer中搜索包含目标词的所有行，:BLines只在当前Buffer中搜索
nnoremap <silent> <Leader>l :Lines<CR>
"<Leader>h在Vim打开的历史文件中搜索，相当于是在MRU中搜索，:History：命令历史查找
nnoremap <silent> <Leader>h :History<CR>
"brew install the_silver_searcher
"ignore files ~/.agignore like: *test.go
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>a :Ag<CR>

Bundle "https://github.com/rizzatti/dash.vim"
:nmap <silent> <leader>d <Plug>DashSearch


"go get -v github.com/rogpeppe/godef;go install -v github.com/rogpeppe/godef
"Bundle 'dgryski/vim-godef'
let godef_split=0

Bundle 'altercation/vim-colors-solarized'
Bundle "https://github.com/Lokaltog/vim-powerline"
    set laststatus=2
"}

" lookupfile setting {
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"./filenametags"'
endif
nmap <leader>o :LookupFile<CR>
"}

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

autocmd FileType c,cpp set colorcolumn=80

" Gui setting {
if has('gui_running')
    set cursorline

    set transparency=5
    set lines=999 columns=999
    " Set input method off
    set imdisable
    set mousehide
    set gfn=Menlo:h15
    set incsearch

    map gh gT
    map gl gt

    Bundle "Solarized"
    colorscheme solarized
    let g:solarized_termtrans  = 1
    let g:solarized_termcolors = 256
    let g:solarized_contrast   = "high"
    let g:solarized_visibility = "high"
endif
" }

"放置在Bundle的设置后，防止意外BUG
filetype plugin indent on
syntax on

" go tag
let g:tagbar_type_go = {
\ 'ctagstype' : 'go',
\ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
\ ],
\ 'sro' : '.',
\ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
\ },
\ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
\ },
\ 'ctagsbin'  : 'gotags',
\ 'ctagsargs' : '-sort -silent'
\ }

set backupskip=/tmp/*,/private/tmp/*
"set makeprg=/Users/lizi/work/bin/vimmake

set vb
set paste

" rust
let g:rustfmt_autosave = 1
