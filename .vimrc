"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

" EDITING BEHAVIOUR
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                   " set show matching parenthesis
set foldenable                  " enable folding
"set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
" set noscrollbind
" syncbind                        " syncronize offsets

" EDITOR LAYOUT
set term=ansi
set termencoding=utf-8
set encoding=utf-8
set ruler                       " show the cursor position all the time
set hlsearch                    " highlight search terms

" VIM BEHAVIOUR
set exrc                        " support local .exrc files
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep a backup file, we have version control, right?
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
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
if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors

   " perfrom some custom highlighting
   highlight comment ctermfg=yellow
endif

" SHORTCUT MAPPINGS
" don't use Ex mode, use Q for formatting
map Q gq

" map Ctrl+space (apparently <Nul>?) to trigger autocompletion
inoremap <Nul> <C-n>

" make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" only do this part when compiled with support for autocommands
if has("autocmd")

   " in text files, always limit the width of text to 78 characters
   autocmd BufRead *.txt,*.tex,*.rst set textwidth=78

   " tabs in Python scripts are evil, so expand them to spaces
   autocmd BufRead *.py set expandtab
   autocmd BufRead *.py set number
   autocmd BufRead *.py set textwidth=72

   " highlight spaces in python
   autocmd BufRead *.py set listchars=tab:»·,trail:·,extends:#
   autocmd BufRead *.py set list

   " run Python files by pressing F5
   autocmd BufRead *.py map <f3> :!pyflakes %<CR>
   autocmd BufRead *.py map <f4> :!python setup.py test<CR>
   autocmd BufRead *.py map <f5> :w<CR>:!python %<CR>

endif " has("autocmd")

" set vi-compatible options
set cpo=aABceFs$

" auto save/restore views for all files (*)
au BufReadPost,BufWritePost * mkview
au BufReadPost,BufWritePost * silent loadview
