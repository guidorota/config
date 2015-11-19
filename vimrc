" Vim, not vi
set nocompatible
filetype off " Required by Vundle

" Set <leader> to , (comma)
let mapleader = ","

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'bronson/vim-visual-star-search'
Plugin 'kien/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
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

" Fix backspace behaviour
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

" Convenience bindings
command WQ wq
command Wq wq
command W w
command Q q

" Reflow paragraph
nnoremap Q gqap

" Home-row shortcuts
nnoremap <Leader>w <c-w>
nnoremap <Leader>s :w<CR>

" Remap CtrlP
let g:ctrlp_map = '<c-l>'
let g:ctrlp_cmd = 'CtrlP'

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Preserve enter behaviour in command line windows
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Disable scratch preview window for completion
set completeopt-=preview

" vim-go settings
let g:go_fmt_fail_silently = 1

" vim-go mappings
au FileType go nmap <Leader>i  <Plug>(go-info)
au FileType go nmap <Leader>d  <Plug>(go-doc)
au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>b  <Plug>(go-build)
au FileType go nmap <Leader>gg <Plug>(go-def)
au FileType go nmap <Leader>gv <Plug>(go-def-vertical)

" c mappings
au FileType c nnoremap <Leader>gg :YcmCompleter GoToDefinition<CR>

