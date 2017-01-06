call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'c.vim'
Plug 'rdnetto/ycm-generator', { 'branch': 'stable'} 
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sensible'
Plug 'sickill/vim-pasta'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()


autocmd VimEnter * NERDTree
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
