source $VIMRUNTIME/defaults.vim
runtime! debian.vim

" Automatically compile .tex file "
autocmd BufWritePost main.tex !pdflatex main.tex; pkill -HUP mupdf

