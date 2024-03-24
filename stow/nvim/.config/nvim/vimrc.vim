let mapleader = ","
let g:mapleader = ","

set number " add line numbers
call plug#begin()
" On-demand loading
" Plug 'github/copilot.vim'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" https://github.com/knight-byte/Vim-Configuration/blob/master/init.vim
" Plug 'neoclide/coc.nvim', {'branch': 'release'
Plug 'Shougo/deoplete.nvim' "Async autocompletion
Plug 'zchee/deoplete-jedi' " Python autocompletion
" Plug 'Shougo/context_filetype.vim' " Completion from other opened files
" Plug 'davidhalter/jedi-vim' " Just to add the python go-to-definition and similar features, autocompletion
" Plug 'ncm2/ncm2'  " awesome autocomplete plugin
" Plug 'ncm2/ncm2-bufword'  " buffer keyword completion

Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'  " make statusline awesome
Plug 'vim-airline/vim-airline-themes'  " themes for statusline 
" Plug 'godlygeek/tabular', {'for':'markdown'}
" Plug 'preservim/vim-markdown', {'for':'markdown'}
" Plug 'iamcco/mathjax-support-for-mkdp', {'for':'markdown'}
" Plug 'iamcco/markdown-preview.vim', {'for':'markdown'}
" Plug 'vim-scripts/indentpython.vim', {'for':'python'}
" Plug 'vim-airline/vim-airline'
" Plug 'danro/rename.vim'
" Plug 'altercation/vim-colors-solarized' 
" " Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sensible'
" Plug 'lervag/wiki.vim', {'for':'markdown'}
call plug#end()

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

"" FZF ignore gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Doge DocString generation
let g:doge_python_settings = {
\  'single_quotes': 0,
\  'omit_redundant_param_types': 1
\}


" ****** Python stuff ******
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix |

" My mappings
nnoremap <leader>ag :Ag<CR>
