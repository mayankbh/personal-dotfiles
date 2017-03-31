call plug#begin()

Plug 'scrooloose/nerdtree'              "File Browsing, t, i, s for tab, horizontal, vertical split opening, m to open menu
Plug 'tpope/vim-fugitive'               "Git wrapper
Plug 'scrooloose/syntastic'             "Syntax checking
Plug 'tpope/vim-surround'               "Easier to modify braces, quotes etc. Use cs<to replace><replacement>, ds=delete surrounding
Plug 'bling/vim-airline'                "Bottom bar
Plug 'scrooloose/nerdcommenter'         "Easier commenting
Plug 'rdnetto/ycm-generator', { 'branch': 'stable'} 
Plug 'christoomey/vim-tmux-navigator'   "Switching between tmux and vim splits easily
Plug 'junegunn/vim-easy-align'          "Select text, then run 'ga' and then <char to align around>
Plug 'tpope/vim-sensible'               "Sensible defaults
Plug 'sickill/vim-pasta'                "Context aware pasting
Plug 'ctrlpvim/ctrlp.vim'               "Fuzzy file finder
Plug 'octol/vim-cpp-enhanced-highlight' "Duh
Plug 'majutsushi/tagbar'                "Tags
Plug 'raimondi/delimitmate'             "Automatically inserting braces, etc
Plug 'shougo/neocomplete.vim'           "Neocomplete
Plug 'shougo/neco-vim'

call plug#end()


"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
"
 function! s:CloseIfOnlyNerdTreeLeft()
   if exists("t:NERDTreeBufName")
       if bufwinnr(t:NERDTreeBufName) != -1
             if winnr("$") == 1
                     q
             endif
       endif
   endif
endfunction

let g:ycm_global_ycm_extra_conf = '.vim/plugged/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

filetype plugin indent on
" show existing tab with 4 spaces width
 set tabstop=4
" " when indenting with '>', use 4 spaces width
 set shiftwidth=4
" " On pressing tab, insert 4 spaces
 set expandtab

 " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
 "
 " " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set number

" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction


nnoremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number | :set rnu!
autocmd InsertLeave * :set relativenumber | :set nu!

"autocmd VimEnter *.c,*.cpp,*.h,*.hpp,*.py,*.sh :TagbarOpen
"autocmd BufWrite *.c,*.cpp,*.h,*.hpp,*.py :call ResetTagbar()

function! ResetTagbar()
    :TagbarClose
    :TagbarOpen
endfunction

let g:tagbar_autoclose = 1
let b:delimitMate_jump_expansion = 1
let b:delimitMate_expand_space = 1
let b:delimitMate_expand_cr = 1
:setlocal foldmethod=syntax

"Set up shortcuts for cscope
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

"Setup shortcuts for Tagbar
nmap <F8> :TagbarToggle<CR>
nmap tb :TagbarToggle<CR>

"Set up shortcut for NERDTree
nmap tn :NERDTreeToggle<CR>

"Enable neocomplete
let g:neocomplete#enable_at_startup = 1 

map ; :
