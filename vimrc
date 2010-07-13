"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

" EDITING BEHAVIOUR
filetype on                     " set filetype stuff to on
filetype plugin on
filetype indent on

set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                   " set show matching parenthesis
set foldenable                  " enable folding
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=8                 " keep 8 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type

" EDITOR LAYOUT
set term=screen-256color
set termencoding=utf-8
set encoding=utf-8
set ruler                       " show the cursor position all the time
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set statusline=%f\ %m\ %r\ %=ln:%l/%L\ col:%c\ buf:%n\ 

" VIM BEHAVIOUR
set exrc                        " support local .exrc files
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep a backup file, we have version control, right?
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
                                " store swap files in one of these directories
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info


" HIGHLIGHTING
if &t_Co >= 256 || has("gui_running")
   colorscheme xoria256
endif

if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif

" SHORTCUT MAPPINGS
" don't use Ex mode, use Q for formatting
map Q gq

" map Ctrl+space (apparently <Nul>?) to trigger autocompletion
inoremap <Nul> <C-n>

" make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Map CTRL-\ to do what ',' used to do
nnoremap <c-\> ,
vnoremap <c-\> ,

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F2
nmap <F2> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F2
nmap <S-F2> :NERDTreeClose<CR>

" Put focus to the NERD Tree with F3 (tricked by quickly closing it and
" immediately showing it again, since there is no :NERDTreeFocus command)
nmap <F3> :NERDTreeClose<CR>:NERDTreeToggle<CR>

" Locate the currently open file in the NERD Tree with F4
nmap <F4> :NERDTreeFind<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="~/.vim/NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$' ]


" only do this part when compiled with support for autocommands
if has("autocmd")

   " in text files, always limit the width of text to 78 characters
   autocmd BufRead *.txt,*.tex,*.rst set textwidth=78

   " tabs in Python scripts are evil, so expand them to spaces
   autocmd BufRead *.py,*.rst set expandtab
   autocmd BufRead *.py,*.rst set number
   autocmd BufRead *.py set textwidth=78

   " highlight any line longer than 80 chars
   autocmd BufRead *.py,*.rst match ErrorMsg '\%>79v.\+'

   " highlight spaces in python
   autocmd BufRead *.py,*.rst set listchars=tab:»·,trail:·,extends:#
   autocmd BufRead *.py,*.rst set list

   " Python (test) runners:
   " - python    is ran with Ctrl-P, Ctrl-P ('p' for Python)
   " - ipython   is ran with Ctrl-P, Ctrl-I ('i' for iPython)
   " - nosetests is ran with Ctrl-P, Ctrl-N ('n' for Nose)
   " - test      is ran with Ctrl-P, Ctrl-T ('t' for test)
   "
   " NOTE:
   " To have these commands work, make sure you have the 'projroot' script
   " on your $PATH.  It is part of this repo.
   "
   autocmd BufRead *.py map <C-p><C-p> :w<CR>:!python %<CR>
   autocmd BufRead *.py map <C-p><C-i> :w<CR>:!ipython %<CR>
   autocmd BufRead *.py map <C-p><C-n> :!(cd $(projroot); nosetests)<CR>
   autocmd BufRead *.py map <C-p><C-t> :!(cd $(projroot); python setup.py test)<CR>

   " Python static source checkers:
   " - pyflakes is ran with Ctrl-K, Ctrl-F ('f' for Flakes)
   " - pep8     is ran with Ctrl-K, Ctrl-P ('p' for PEP8)
   " - both     are ran with Ctrl-K, Ctrl-K (for the given file)
   " - both     are ran for all files in the project with Ctrl-K, Ctrl-A
   autocmd BufRead *.py map <C-k><C-f> :!pyflakes %<CR>
   autocmd BufRead *.py map <C-k><C-p> :!pep8 -r %<CR>
   autocmd BufRead *.py map <C-k><C-k> :!(pyflakes %; pep8 -r %)<CR>
   autocmd BufRead *.py map <C-k><C-a> :!find $(projroot) -name '*.py' \| xargs pyflakes; find $(projroot) -name '*.py' \| xargs pep8 -r<CR>

endif " has("autocmd")

" set vi-compatible options
set cpo=aABceFs$

" auto save/restore views for all files (*)
au BufReadPost,BufWritePost * mkview
au BufReadPost,BufWritePost * silent loadview
