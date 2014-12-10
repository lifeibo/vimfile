set nocompatible          "不要兼容vi
filetype off              "必须的设置：

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

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fenc=utf-8
set autoindent
set hidden
set cindent
set encoding=utf-8

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

"自动换行
set wrap
"将-连接符也设置为单词
set isk+=-
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

"修改vim的正则表达
nnoremap / /\v
vnoremap / /\v

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

"Vundle Settings {
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'matchit.zip'
Bundle 'Tabular'
Bundle 'trailing-whitespace'
Bundle "ayang/AutoComplPop"

Bundle 'The-NERD-tree'
  "设置相对行号
  nmap <leader>nt :NERDTree<cr>
  let NERDTreeShowBookmarks=1
  let NERDTreeShowFiles=1
  let NERDTreeShowHidden=1
  let NERDTreeIgnore=['\.$','\~$']
  let NERDTreeShowLineNumbers=1
  let NERDTreeWinPos=1

Bundle "https://github.com/812lcl/visualmark"
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
      map <unique> <c-p> <Plug>Vm_goto_prev_sign
    endif
    nnoremap <silent> <script> <Plug>Vm_goto_prev_sign	:call Vm_goto_prev_sign()<cr>


Bundle "https://github.com/fsouza/go.vim"
Bundle "https://github.com/vim-scripts/a.vim"
Bundle "https://github.com/lifeibo/vimfile"

Bundle "https://github.com/rizzatti/dash.vim"
:nmap <silent> <leader>d <Plug>DashSearch

Bundle "Solarized"
Bundle "https://github.com/Lokaltog/vim-powerline"
    set laststatus=2
"}

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Gui setting {
if has('gui_running')
    set cursorline

    set transparency=5
    set lines=999 columns=999
    " Set input method off
    set imdisable
    set mousehide
    set gfn=Menlo:h19
    set incsearch

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

