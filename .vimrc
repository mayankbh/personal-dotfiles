call plug#begin()

" File Organization/Code Browsing
Plug 'scrooloose/nerdtree'              "File Browsing, t, i, s for tab, horizontal, vertical split opening, m to open menu
Plug 'jistr/vim-nerdtree-tabs'          "NerdTree + Tabs
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " Fuzzy finder
Plug 'rking/ag.vim'                     " Silver searcher
Plug 'majutsushi/tagbar'                "Tags

" Git
Plug 'tpope/vim-fugitive'               "Git wrapper
Plug 'xuyuanp/nerdtree-git-plugin'      "Show git status in NerdTree

" Linting/Syn
Plug 'w0rp/ale'

" Terminal quality of life
Plug 'bling/vim-airline'                "Bottom bar
Plug 'tpope/vim-obsession'              "Track vim sessions
Plug 'christoomey/vim-tmux-navigator'   "Switching between tmux and vim splits easily

" Quality of Life 
Plug 'raimondi/delimitmate'             "Automatically inserting braces, etc
Plug 'nathanaelkane/vim-indent-guides'  "Indent guides
Plug 'junegunn/vim-easy-align'          "Select text, then run 'ga' and then <char to align around>
Plug 'sickill/vim-pasta'                "Context aware pasting

" Language specific
Plug 'fatih/vim-go'                     "Go development plugin
Plug 'rust-lang/rust.vim'               "Rust development plugin
Plug 'suan/vim-instant-markdown'        "Markdown preview
Plug 'jansenm/vim-cmake'                "Cmake reference/autocompletion
Plug 'pboettch/vim-cmake-syntax'        
Plug 'elixir-lang/vim-elixir'           "Elixir
Plug 'pangloss/vim-javascript'          "Javascript Linting
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'

" Miscellaneous
Plug 'tpope/vim-sensible'               "Sensible defaults
Plug 'vimwiki/vimwiki'                  "Useful for note taking
Plug 'dhruvasagar/vim-table-mode'       "Table creation


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
"nmap tn :NERDTreeToggle<CR>
nmap tn :NERDTreeTabsToggle<CR>

map ; :

let mapleader = ","

"Setup shortcut for Table Mode Toggle
nmap tm :TableModeToggle<CR>

"You can use the following to quickly enable / disable table mode in insert
"mode by using || or __ :
"function! s:isAtStartOfLine(mapping)
"  let text_before_cursor = getline('.')[0 : col('.')-1]
"  let mapping_pattern = '\V' . escape(a:mapping, '\')
"  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
"  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
"endfunction
"
"inoreabbrev <expr> <bar><bar>
"          \ <SID>isAtStartOfLine('\|\|') ?
"          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
"inoreabbrev <expr> __
"          \ <SID>isAtStartOfLine('__') ?
"          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
"
"Markdown compatible tables
let g:table_mode_corner='|'

"Shortcut to Tableize
nmap tt :Tableize

xmap tt :Tableize

let g:table_mode_delete_row_map = 'tdd'
let g:table_mode_delete_column_map = 'tdc'

let g:table_mode_motion_up_map = 'tk'
let g:table_mode_motion_down_map = 'tj'
let g:table_mode_motion_left_map = 'th'
let g:table_mode_motion_right_map = 'tl'

colorscheme default


nmap tp :CtrlP <CR>
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"Hopefully nicer looking splits
set fillchars+=vert:\ 

"Setup CODI for Python
let g:codi#interpreters = {
                   \ 'python': {
                       \ 'bin': 'python',
                       \ 'prompt': '^\(>>>\|\.\.\.\) ',
                       \ },
                   \ }

"Variable to hold state of spellcheck
let s:spellingenabled = 0

"Flip the aforementioned variable
function! ToggleSpelling()
    if s:spellingenabled
        setlocal nospell
        let s:spellingenabled = 0
    else
        setlocal spell spelllang=en_gb
        let s:spellingenabled = 1
    endif
endfunction

"Map ts -> toggle spelling
nmap <silent> ts :call ToggleSpelling()<CR>

"Make it easier to access vimwiki using tww
"Other shortcuts
"wt - open index file in new tab
"ws - select and open wiki index file
"wd - delete current wiki file
"wr - rename current wiki file
nmap tww <Leader>ww
nmap twt <Leader>wt
nmap tws <Leader>ws
nmap twd <Leader>wd
nmap twr <Leader>wr




"Autorun clang format on buffer write
autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable
autocmd FileType h ClangFormatAutoEnable
autocmd FileType hpp ClangFormatAutoEnable




let g:clang_format#style_options = {
    \ "BreakBeforeBraces": "Allman"}


let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"

"Remap Ctrl + P to call FZF's file search
nnoremap <C-F> :Files<CR>     

" Silver searcher shortcut
nnoremap <C-A> :Ag<CR>

"Remap Ctrl + O to call FZF's commit search
nnoremap <C-O> :Commits<CR>

" Remap jk and kj to <ESC>
inoremap jk <ESC>
inoremap kj <ESC>
