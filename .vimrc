set nocompatible
set number
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab " 用空格代替tab
set hlsearch incsearch
set nowrap
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

set ruler           "在左下角显示当前文件所在行
set showcmd         "在状态栏显示命令
set showmatch       "显示匹配的括号
let mapleader = "\<Space>"
" set foldmethod=indent   "缩进作为折叠标识

"80字符划线自动换行
" set colorcolumn=81
set textwidth=80
set fo+=mB

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"set background=dark
colorscheme molokai "solarized desert 
set t_Co=256 

set cursorline
hi CursorLine term=reverse cterm=bold ctermbg=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,cp936

set ambiwidth=double
set termencoding=utf-8

set mouse=a

let g:netrw_liststyle=3

map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
function! RunPython()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  setlocal makeprg=python\ -u
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  copen
  let &makeprg = mp
  let &errorformat = ef
endfunction

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

"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

"template
autocmd! BufNewFile * silent! 0r ~/.vim/template/Template.%:e

vnoremap <Leader>y "*y
vnoremap <Leader>p "+p
nnoremap <Leader>y "*y
nnoremap <Leader>p "+p

noremap <silient> <Up>   :cp <CR>
noremap <silient> <Down> :cn <CR>
noremap <silient> <Left>  :lp <CR>
noremap <silient> <Right> :lne <CR>

inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

" Map ; to : and save a million keystrokes 用于快速进入命令行
"nnoremap ; :

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
"Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'

Plug 'vim-scripts/dbext.vim'
let g:dbext_default_profile_mySQL = 
	\ "type=MYSQL:user=david:passwd=test:dbname=test"
let g:dbext_default_profile = 'mySQL'

let g:dbext_default_profile_POPFile = 
    \'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/git/flasky/data-test.sqlite'

" 语法检查
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['💣⨉%d', '⚠ %d', '⬥ ok']

Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdcommenter'
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

Plug 'Yggdroot/indentLine'
"缩进指示线"
let g:indentLine_char='┆'
let g:indentLine_enabled = 1

Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

Plug 'tell-k/vim-autopep8'
let g:autopep8_max_line_length=79
let g:autopep8_disable_show_diff=1

" Plug 'klen/python-mode'
" let g:pymode = 1
" let g:pymode_trim_whitespaces = 1
" let g:pymode_options = 1
" let g:pymode_options_max_line_length = 79
" let g:pymode_quickfix_maxheight = 6
" let g:pymode_quickfix_minheight = 3
" let g:pymode_python = 'python'
" let g:pymode_indent = 1
" let g:pymode_doc = 1
" let g:pymode_motion = 1
" let g:pymode_run = 1
" let g:pymode_run_bind = '<leader>r'
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'
" let g:pymode_rope_completion = 0
" let g:pymode_rope = 0


" Initialize plugin system
call plug#end()

" Statusline

let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004'
  else
    exe 'hi! StatusLine ctermfg=006'
  endif

  return ''
endfunction

" Find out current buffer's size and output it.
function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return mbytes . 'MB '
    elseif (exists('kbytes'))
        return kbytes . 'KB '
    else
        return bytes . 'B '
    endif
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

set timeoutlen=1000 ttimeoutlen=0
set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %{GitInfo()}                        " Git Branch name
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%{fugitive#statusline()}                 " Fugtive
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ ࿊\ %l:\ %3c\                 " Rownumber/total (%)

hi User1 ctermfg=007
hi User2 ctermfg=008
hi User3 ctermfg=008
hi User4 ctermfg=008
hi User5 ctermfg=008
hi User7 ctermfg=008
hi User8 ctermfg=008
hi User9 ctermfg=007
