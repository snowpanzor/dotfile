set nocompatible
set fileencodings=gb18030,gb2312,cp936 "recognize code sequence 
set fileencoding=gb18030 "gvim save code
set encoding=utf-8 "gvim display code
set number
set relativenumber
set hls
set showcmd

set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

"set guifont=DejaVu\ Sans\ Mono:10
"set guifontwide=DejaVu\ Sans\ Mono:10
set guifont=Roboto\ Mono\ for\ Powerline\ 10
set guifontwide=Roboto\ Mono\ for\ Powerline\ 10
au InsertEnter * hi StatusLine guibg=#818D29 guifg=#FCFCFC gui=none 
au InsertLeave * hi StatusLine guibg=Yellow guifg=SlateBlue gui=none
