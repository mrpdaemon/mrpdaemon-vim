" Mark R. Pariente's vim configuration file

set nocompatible                " Use Vim settings instead of vi - must be first
                                " line

" Plugin configuration
" -------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'chazy/cscope_maps'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'MarcWeber/vim-addon-local-vimrc'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'myusuf3/numbers.vim'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'ternjs/tern_for_vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'junegunn/fzf'
Plugin 'rhysd/vim-clang-format'
Plugin 'augmentcode/augment.vim'

call vundle#end()
" -------------------------------------------------------------------------

filetype plugin indent on                      " Automatically detect file types

" ViM behavior
set nobackup                                   " don't keep backup files
set noswapfile                                 " don't keep swap files
set history=1000                               " keep a lot of cmdline history
set showcmd                                    " display incomplete commands
set incsearch                                  " do incremental searching
set scrolloff=5                                " keep 5 lines above/below cursor
                                               " when scrolling
set clipboard=unnamedplus                      " copy/paste with system clipboard

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
set t_Co=256                                   " Use 256 color terminal
set background=dark                            " Prefer dark background
colorscheme xoria256                           " Set color scheme
set nu                                         " show line numbers + dark grey
set cursorline                                 " highlight current line
set colorcolumn=80                             " color 80th column as guide
highlight ColorColumn ctermbg=238 guibg=#444444
" Use bold typefaces for syntax highlighting special keywords
highlight Type cterm=bold gui=bold
highlight Function cterm=bold gui=bold
highlight Conditional cterm=bold gui=bold
highlight Statement cterm=bold gui=bold
highlight Include cterm=bold gui=bold
highlight Boolean cterm=bold gui=bold
highlight Identifier cterm=bold gui=bold
highlight Macro cterm=bold gui=bold
highlight PreProc cterm=bold gui=bold

" Status line
" -------------------------------------------------------------------------
set laststatus=2                               " always show status line
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
" In unclosed parenthesis scopes indent new lines with next char after opening
" parenthesis.
set cino=(0
" Vala
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

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
" Allow toggling list characters
nmap <leader>l :set list!<CR>
" Rotate windows
nmap <leader>r <C-W><C-R>
" Preview current tag
nmap <leader>] <C-W>}

" Plugin configurations

" NERDTree
nmap <leader>nt :NERDTreeToggle<CR>:NERDTreeMirror<CR>
let NERDTreeQuitOnOpen=1                  " quit when opening stuff
let NERDTreeKeepTreeInNewTab=1            " keep tree in a new tab
let NERDTreeShowHidden=1                  " show hidden files
let NERDTreeIgnore=['\~$','\.swp$','\.git']
let g:NERDTreeWinSize=60                  " larger width
"let g:NERDTreeDirArrows = 0               " Fix unicode issue with arrows

" TagBar
nnoremap <silent> <leader>t :TagbarToggle<CR>
let tagbar_autoclose=1                    " close when tag is selected
let tagbar_autofocus=1                    " focus tagbar when opened
let g:tagbar_width=60                     " larger TagBar

" Fugitive
nnoremap <silent> <leader>gs :Git status<CR>
nnoremap <silent> <leader>gd :Git diff<CR>
nnoremap <silent> <leader>gm :Git diff master %<CR>
nnoremap <silent> <leader>gc :Git commit -a<CR>
nnoremap <silent> <leader>ga :Git commit -a --amend<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gl :Git log<CR>
nnoremap <silent> <leader>gp :Git push<CR>

" Cscope
if filereadable("cscope.out")
   cscope add cscope.out
   nmap <leader>ff :cs f f<space>
   nmap <leader>fs :cs f s<space>
   nmap <leader>fg :cs f g<space>
   nmap <leader>fc :cs f c<space>
endif

" Numbers
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" Undotree
map <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1       " focus when toggled

" vim-indent-guides
let g:indent_guides_start_level = 2       " Start from level 2
let g:indent_guides_auto_colors = 0       " Custom guide colors
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=237 guibg=#444444
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238 guibg=#444444

" ctrlp
nmap <leader>p :CtrlPBuffer<CR>
nmap <leader>o :CtrlP<CR>
let g:ctrlp_max_files = 0                 " No limit to the number of files
let g:ctrlp_max_depth = 40                " Large projects hit depth limit
let g:ctrlp_lazy_update = 1               " Slow to search on every key press
let g:ctrlp_by_filename = 1               " Only search file names

" vim-bufferline
let g:bufferline_echo = 0                  " Don't echo buffer name to cmd bar
let g:bufferline_rotate = 1                " Rotate buffers
let g:bufferline_fixed_index = -1          " Fix current buffer to last position

" vim-airline
let g:airline#extensions#whitespace#enabled = 0 " Disable whitespace warnings
let g:airline#extensions#tagbar#enabled = 0     " Disable tagbar integration
let g:airline_section_y = ''                    " Don't want encoding info
let g:airline_theme = 'base16'                  " Theme selection

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1 " auto close preview window
let g:ycm_global_ycm_extra_conf = '/home/mark/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" UltiSnips
let g:UltiSnipsExpandTrigger = '<c-space>'

" Silver searcher (ag.vim)
nmap <leader>a :Ag<CR>

" FZF
map <leader>f :FZF<CR>

" clang-format
let g:clang_format#detect_style_file = 1 " detect .clang-format files
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c,cpp ClangFormatAutoEnable " auto enable auto format on save

" augment
nnoremap <leader>ac :Augment chat<CR>
vnoremap <leader>ac :Augment chat<CR>
nnoremap <leader>an :Augment chat-new<CR>
vnoremap <leader>an :Augment chat-new<CR>
nnoremap <leader>at :Augment chat-toggle<CR>
