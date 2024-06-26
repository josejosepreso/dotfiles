source $VIMRUNTIME/defaults.vim
runtime! debian.vim

" Automatically compile .tex file "
autocmd BufWritePost main.tex !pdflatex main.tex; pkill -HUP mupdf

" Automatically compile config.h file "
autocmd BufWritePost config.h !sudo make clean install

" Change cursor to steady block
autocmd VimEnter * silent !echo -ne "\e[2 q"
