"        _                    
" __   _(_)_ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
"   \_/ |_|_| |_| |_|_|  \___|
                            

source $VIMRUNTIME/defaults.vim
runtime! debian.vim

"
set number relativenumber

"
set shiftwidth=4
filetype indent off

" 
map Q !!$SHELL<Enter>

" Automatically compile .tex file "
autocmd BufWritePost main.tex !pdflatex main.tex; pkill -HUP mupdf

" Automatically compile config.h file "
autocmd BufWritePost config.h !sudo make clean install

" Change cursor to steady block
autocmd VimEnter * silent !echo -ne "\e[2 q"
