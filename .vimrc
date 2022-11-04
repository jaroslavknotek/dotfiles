set number " add line numbers
call plug#begin()
" On-demand loading
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular', {'for':'markdown'}
Plug 'preservim/vim-markdown', {'for':'markdown'}
Plug 'iamcco/mathjax-support-for-mkdp', {'for':'markdown'}
Plug 'iamcco/markdown-preview.vim', {'for':'markdown'}
Plug 'vim-scripts/indentpython.vim', {'for':'python'}
Plug 'vim-airline/vim-airline'
Plug 'danro/rename.vim'
Plug 'altercation/vim-colors-solarized' 
" Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-eunuch'
call plug#end()

" fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-p': ':r !echo',
  \ 'ctrl-y': ':r !echo %:p | xclip -selection clipboard',
  \ }

" Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
" ~~x~~ produces strike through x
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:mkdp_path_to_chrome = "/snap/bin/firefox"
"colorscheme
" let g:solarized_termcolors=256
" set background=dark
" colorscheme solarized
" syntax enable

" move lines
" alt and meta doesnt work
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
nnoremap j :m .+1<CR>==
nnoremap k :m .-2<CR>==
inoremap j <Esc>:m .+1<CR>==gi
inoremap k <Esc>:m .-2<CR>==gi
vnoremap j :m '>+1<CR>gv=gv
vnoremap k :m '<-2<CR>gv=gv

" there is a delay in returning from insert mode
" https://vi.stackexchange.com/questions/16148/slow-vim-escape-from-insert-mode
set timeoutlen=100
set ttimeoutlen=50

" stop vim giving warning about modified buffer
set hidden
" write buffer and delete
" let mapleader=","
command WriteBufferDelete write|bdelete
nnoremap ZB :WriteBufferDelete<CR>

" Python stuff
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix |


