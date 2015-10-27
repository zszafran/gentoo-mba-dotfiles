colorscheme tir_black

syntax on

set nu
set autoindent
set nowrap
set ts=2 sw=2 et
set background=dark
set guioptions-=T
set expandtab
set shiftwidth=2
set softtabstop=2
set wrap linebreak textwidth=0
set tw=0
set guitablabel=%!expand(\"\%:t\")

set rtp+=/usr/lib64/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

call pathogen#infect()
call pathogen#helptags()

let mapleader = ","
let g:mapleader = ","
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 1

highlight OverLength ctermbg=red ctermfg=white guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
highlight StyleGuideError ctermbg=red guibg=red

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray15  ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black   ctermbg=black
autocmd BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
autocmd BufWinEnter * let w:m2=matchadd('OverLength', '\%>80v.\+', -1)
autocmd BufWinEnter * let w:m3=matchadd('ExtraWhitespace', '\s\+$', -1)
autocmd BufWinEnter *.js let w:m4=matchadd('StyleGuideError', '".\+"', -1)
autocmd BufWinEnter *.js let w:m5=matchadd('StyleGuideError', '(\s\+.*\s\+)', -1)
autocmd BufWinEnter *.js let w:m6=matchadd('StyleGuideError', '\[\s\+.*\s\+\]', -1)
autocmd BufNewFile,BufRead *.gss set filetype=css

let g:Powerline_symbols = "fancy"
