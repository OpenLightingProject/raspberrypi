filetype on
filetype indent on

syntax on
set tabstop=4
set shiftwidth=2
set smarttab
set autoindent
set smartindent
set expandtab
"set noexpandtab
set nocindent

set textwidth=79

set list
set listchars=tab:\ \ ,trail:\ ,extends:?,precedes:?
highlight SpecialKey ctermbg=Yellow guibg=Yellow
set comments=s1:/*,mb:*,elx:*/
set fo+=r
set cul
hi Comment ctermfg=darkmagenta
:match Todo '\%81v.*'
:set vb t_vb=".

" http://www.vim.org/scripts/script.php?script_id=2654
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
