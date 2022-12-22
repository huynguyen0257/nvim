"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               "               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" "

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable tpe file detection. Vim will be able to try to detect the type of file in use.
"filetype on

" Enable plugins and load plugin for the detected file type.
"filetype plugin on

" Load an indent file for the detected file type.
"filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" On pressing tab, insert 2 spaces
set expandtab

" Use tab on visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')


  Plug 'dense-analysis/ale'

  " {{{ File brower }}}
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'PhilRunninger/nerdtree-buffer-ops'

  " {{{ Debugging }}}
  Plug 'puremourning/vimspector'

  " {{{ Themes }}}
  Plug 'joshdick/onedark.vim'
  Plug 'artanikin/vim-synthwave84'
  Plug 'morhetz/gruvbox'
  " Plug 'tjdevries/colorbuddy.nvim'
  " Plug 'lalitmee/cobalt2.nvim'

  " {{{ File search }}}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  
  " {{{ Status bar }}}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " {{{ Terminal }}}
  Plug 'voldikss/vim-floaterm'

  " {{{ Code Intelligence }}}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'github/copilot.vim'

  " {{{ Source code version control - Git }}}
  Plug 'tpope/vim-fugitive'

  " {{{ Editor support plugin }}}
  Plug 'preservim/nerdcommenter'

   " {{{ Auto pair for {} || ''  ||  [] }}}
   Plug 'jiangmiao/auto-pairs'

call plug#end()

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

inoremap jk <Esc>
" Set the backslash as the leader key.
let mapleader = '\'

" Deletes the buffer (which translates to close the file)
nnoremap <silent> <c-w> :bd<cr>

" Change in parenthesis
nnoremap cp ci(

" Delete in parenthesis
nnoremap dp di(

" Move forward/backward buffer/file
nnoremap <c-i> <c-o>
nnoremap <c-o> <c-i>

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``
nnoremap <space> :
"
" Pressing the letter o will open a new line below the current one & Exit insert mode
nnoremap o o<esc>
nnoremap O O<esc>
"
" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz
"
" Yank from cursor to the end of line.
nnoremap Y y$
"
" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-n> <c-w>v
nnoremap <down> <c-w>j
nnoremap <up> <c-w>k
nnoremap <left> <c-w>h
nnoremap <right> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <m-up> <c-w>+
noremap <m-down> <c-w>-
noremap <m-left> <c-w>>
noremap <m-right> <c-w><

" Move in insert mode
" inoremap <c-h> <left>
" inoremap <c-l> <right>
" inoremap <c-j> <down>
" inoremap <c-k> <up>

" Delete in insert mode
" inoremap <c-d> <Bs>

" Delete without yarn
nnoremap x "_x

" Yarn to system clipboard
if has('win32')
    echo "Someone please open the Window(s)!"
    source $HOME/.config/nvim/os-setting/win.vim
endif
if has('macunix')
    echo "Someone please open the Mac(s)!"
    source $HOME/.config/nvim/os-setting/mac.vim
endif

" NERDTree specific mappings.
source $HOME/.config/nvim/settings/NERDTree.vim

" Vimspector specific mappings.
source $HOME/.config/nvim/settings/vimspector.vim

" Vim floaterm specific mappings.
source $HOME/.config/nvim/settings/vim-floaterm.vim

" Vim coc specific mappings.
source $HOME/.config/nvim/settings/coc-nvim.vim

" Vim airline specific mappings.
source $HOME/.config/nvim/settings/airline.vim

" Fzf fim mapping
source $HOME/.config/nvim/settings/fzf.vim

" Nerdcommenter config
source $HOME/.config/nvim/settings/nerd-commenter.vim

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{
" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif
" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
augroup END

""" Customize float window colors
func! s:my_colors_setup() abort
    " this is an example
    hi Pmenu guibg=#082047 gui=NONE
endfunc

augroup colorscheme_coc_setup | au!
    au ColorScheme * call s:my_colors_setup()
augroup END

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F2> :call ToggleQuickFix()<cr>

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=
" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" Show the status on the second to last line.
set laststatus=2

" }}}

" {{{ Themes setup }}}
" source $HOME/.config/nvim/themes/onedark.vim
" source $HOME/.config/nvim/themes/vim-synthwave84.vim
source $HOME/.config/nvim/themes/morhetz-gruvbox.vim
" lua require('colorbuddy').colorscheme('cobalt2')
