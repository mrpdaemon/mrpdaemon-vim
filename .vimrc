" Mark R. Pariente's vim configuration file

set nocompatible                " Use Vim settings instead of vi - must be first
                                " line

" Bundle configuration
" -------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'chazy/cscope_maps'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'majutsushi/tagbar'
Bundle 'techlivezheng/vim-plugin-minibufexpl'
" -------------------------------------------------------------------------

filetype plugin indent on                      " Automatically detect file types

" ViM behavior
set nobackup                                   " don't keep backup files
set history=1000                               " keep a lot of cmdline history
set showcmd                                    " display incomplete commands
set incsearch                                  " do incremental searching
set scrolloff=5                                " keep 5 lines above/below cursor
                                               " when scrolling

" ViM UI
syntax on                                      " syntax highlighting
set invhlsearch                                " don't highlight searches by default
set ruler                                      " always show the cursor position
set showmode                                   " display current mode
set showcmd                                    " show partial commands
set showmatch                                  " show matching parenthesis
set wildmenu                                   " vim command completion
set wildmode=list:longest,full                 " list matches, longest common, all
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight wspace/TAB problems
set nu                                         " show line numbers + dark grey
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Status line
" -------------------------------------------------------------------------
set laststatus=2                               " always show status line
set statusline=%<%f\                           " Filename
set statusline+=%{fugitive#statusline()}       " Git Hotness
set statusline+=\ [%{getcwd()}]                " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%        " Right aligned file nav info
" -------------------------------------------------------------------------

" Formatting
set autoindent                                 " automatically indent
set nowrap                                     " wrap long lines
set expandtab                                  " use spaces not TABs
set shiftwidth=3                               " 3 spaces per indent
set tabstop=3                                  " indent every 3 columns
set softtabstop=3                              " let backspace delete indents
set smarttab                                   " Let TAB/BSpace insert/delete spaces

" Per-language settings
" C
autocmd FileType c,cpp setlocal cindent        " C indentation rules

" Controls
set backspace=indent,eol,start                 " backspace in insert mode
set whichwrap=b,s,h,l,<,>,[,]                  " backspace/cursor keys wrap too
let mapleader=','                              " remap <Leader> to ,
" Easy window movements with CTRL+jklh
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
" Yank from the cursor to the end of the line, consistent with C and D
nnoremap Y y$
" Toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>
" Visual shifting
vnoremap < <gv
vnoremap > >gv
" Easier horizontal scrolling
map zl zL
map zh zH

" Plugin configurations

" MiniBufExplorer
nmap <leader>gt :MBEbn<CR>
nmap <leader>gT :MBEbp<CR>

" NERDTree
nmap <leader>nt :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nmap <leader>nf :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1                  " quit when opening stuff
let NERDTreeKeepTreeInNewTab=1            " keep tree in a new tab
let NERDTreeShowHidden=1                  " show hidden files
let NERDTreeIgnore=['\~$','\.swp$','\.git']
"let g:NERDTreeDirArrows = 0               " Fix unicode issue with arrows

" TagBar
nnoremap <silent> <leader>tt :TagbarToggle<CR>
let tagbar_autoclose=1                    " close when tag is selected
let tagbar_autofocus=1                    " focus tagbar when opened

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>ga :Git commit --amend<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Git log<CR>

" Cscope
if filereadable("cscope.out")
   cscope add cscope.out
endif
nmap <leader>ff :cs f f<space>
nmap <leader>fs :cs f s<space>
nmap <leader>fg :cs f g<space>
nmap <leader>fc :cs f c<space>
