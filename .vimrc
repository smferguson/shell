
" Pathogen load
"filetype off
filetype on

"call pathogen#infect()
"call pathogen#helptags()

"#filetype plugin indent on

set tabstop=2
set expandtab
set shiftwidth=2
set background=dark
set hlsearch
set wrap
set colorcolumn=80

" changing/setting file formats:
" dos2unix is a commandline utility that will do this, or
" 
" :%s/^M//g
" will if you use ctrl-v ctrl-m to input the ^M. Or you can:
" 
" :set ff=unix
"
set ff=unix
syntax on
colorscheme koehler

set history=700

" set copy buffer to 1000 lines and increase max register size
set viminfo='20,<1000,s1000

"define custom highlight group
hi User1 ctermbg=blue  ctermfg=green guibg=blue  guifg=green
hi User2 ctermbg=black  ctermfg=green guibg=black  guifg=green
hi colorcolumn ctermbg=8

set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%2*  "switch to User1 highlight
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


" automatically restart cherrypy when saving a .py file
"au BufWritePost *.py !/usr/local/s2/bin/s2daemons restart cherrypy 

" pieced together from here:
" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
"
"au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif

" remember where I last was in a file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif


