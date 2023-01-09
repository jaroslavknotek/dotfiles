let mapleader = ","
let g:mapleader = ","

" there is a delay in returning from insert mode
" https://vi.stackexchange.com/questions/16148/slow-vim-escape-from-insert-mode
set timeoutlen=200
set ttimeoutlen=200

" stop vim giving warning about modified buffer
set hidden


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
Plug 'tpope/vim-sensible'
Plug 'lervag/wiki.vim', {'for':'markdown'}
call plug#end()

" ****** wiki.vim ******
let g:wiki_root = '~/documents/notes_vault/notes'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'

" ****** wildmenu ******
function! OpenCompletion()
    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
        call feedkeys("\<C-x>\<C-o>", "n")
    endif
endfunction

" autocmd InsertCharPre * call OpenCompletion()
set wildmenu
set wildmode=longest:full,full
" https://stackoverflow.com/a/47967462/3228432
set completeopt+=menuone,noselect,noinsert
" https://stackoverflow.com/a/70816950/3228432
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" ****** fzf ******
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

function! s:copy_fn_to_clipboard(lines)
  let @+=a:lines[0]
  echo "Copied to clipboard: ". a:lines[0] 
endfunction

" Insert text at the current cursor position.
" https://vi.stackexchange.com/a/28026
function! InsertText(text)
    let cur_line_num = line('.')
    let cur_col_num = col('.') + 1
    let orig_line = getline('.')
    let modified_line =
        \ strpart(orig_line, 0, cur_col_num - 1)
        \ . a:text
        \ . strpart(orig_line, cur_col_num - 1)
    " Replace the current line with the modified line.
    call setline(cur_line_num, modified_line)
    " Place cursor on the last character of the inserted text.
    call cursor(cur_line_num, cur_col_num + strlen(a:text))
endfunction


function! s:insert_selected_filename(lines)
  let l:filename =a:lines[0]
  let l:noext = fnamemodify(l:filename, ":r")
  echo "Filename is ". l:noext
  call InsertText(l:noext)
endfunction



let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-p': function('s:insert_selected_filename'),
  \ 'ctrl-y': function('s:copy_fn_to_clipboard'),
  \ }

" ****** Markdown settings ******
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

" ****** Move lines ******
" alt and meta doesnt work
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
nnoremap j :m .+1<CR>==
nnoremap k :m .-2<CR>==
inoremap j <Esc>:m .+1<CR>==gi
inoremap k <Esc>:m .-2<CR>==gi
vnoremap j :m '>+1<CR>gv=gv
vnoremap k :m '<-2<CR>gv=gv

" ****** write buffer and delete *******
command WriteBufferDelete write|bdelete
nnoremap ZB :WriteBufferDelete<CR>

" ****** file metadata to cliboard ******
" filename to clipboard https://stackoverflow.com/a/17096082/3228432
" absolute path (/something/src/foo.txt)
nnoremap cfp :let @+=expand("%:p")<CR>
" filename (foo.txt)
nnoremap cfn :let @+=expand("%:t")<CR>
" directory name (/something/src)
nnoremap cfd :let @+=expand("%:p:h")<CR>

" ****** Python stuff ******
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix |

" ****** Delete ******
" (send to black hole registry)
noremap ' "_

nnoremap <leader>ag :Ag<CR>
nnoremap <leader>t :eval(expand("%:p:n"))


" ****** Notest ******
function! s:CreateScratch(args)
  let timestamp = trim(system("date +%Y%m%d%H%M"))
  let filename = 'scratch.'.timestamp
  if len(a:args) !=0
    let filename = filename.'.'.a:args
  endif
  let filename = filename.".md"
  execute "e ".filename
"  echo "Created new file ".filename
endfunction

command -nargs=* Scratch :call s:CreateScratch(<q-args>)

" Prevent vim from clearing clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))
