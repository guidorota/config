" Vim, not vi
set nocompatible
filetype off " Required by Vundle

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'bronson/vim-visual-star-search'
Plugin 'kien/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'

call vundle#end()            " Required by Vundle
filetype plugin indent on    " Required by Vundle

" Command history
set history=1000

" Search options
set incsearch " find next match as we type
set hlsearch " highlight search results
set ignorecase " case-insensitive search by default

" Syntax highlight
syntax off
filetype plugin indent on

" Set color scheme
set t_Co=256
set background=light  
highlight Normal ctermfg=Black

" Automatically wrap lines to 79 characters
set textwidth=79
set formatoptions+=t
set colorcolumn=80
highlight colorcolumn ctermbg=white

" Fix backspace
set backspace=2

" Line numbers
set number
highlight LineNr ctermfg=grey

" Status line
set laststatus=2
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" Indent and tab options
set smartindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" Set default statusline color to green when entering Vim
hi statusline ctermbg=white
hi statusline ctermfg=black

" Change status line color when mode changes
au InsertEnter * hi statusline ctermfg=darkcyan
au InsertChange * hi statusline ctermfg=darkcyan
au InsertLeave * hi statusline ctermfg=black

" No timeout when pressing ESC to exit insert mode
set timeoutlen=0

" Convenience bindings
command WQ wq
command Wq wq
command W w
command Q q

" Add newlines in normal mode
nnoremap <CR> io<Esc>

" Reflow paragraph
nnoremap Q gqap

" Remap CtrlP
let g:ctrlp_map = '<c-m>'
let g:ctrlp_cmd = 'CtrlP'

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Map key to toggle opt
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Assign paste toggle to ctrl-p
MapToggle <c-p> paste

" Preserve enter behaviour in command line windows
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>
