set noimdisable
autocmd! InsertLeave * set imdisable|set iminsert=0
autocmd! InsertEnter * set noimdisable|set iminsert=0

"重新映射 Esc 和 leader 键
inoremap jj <ESC>
let mapleader = ";"

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

"显示行号
set number

"语法高亮
syntax on

"设置tap键为4个空格
set tabstop=4

"打开状态栏标尺
set ruler

"智能对齐方式
set smartindent

"总是显示状态栏
set laststatus=2

"选择编码
set encoding=utf-8

"设置颜色主题
colorscheme molokai

"设置macvim窗口大小
"set lines=50 columns=128

"启动时自动开启
"autocmd vimenter * NERDTree

if(has("gui_running"))

	"解决输入法问题
	"filetype off
	call pathogen#infect()
	call pathogen#helptags()
	"Pathogen 插件
	call pathogen#infect()


	"没有文件启动时自动开启 NERDTree
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if !argc() == 0 && !exists("s:std_in") | NERDTree | endif

	"没有文件时自动关闭 NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif
