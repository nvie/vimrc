"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"
" My personally preferred version of vim is the one with the "normal" feature
" set, in addition to the following configure options:
"
"     ./configure --enable-pythoninterp --enable-multibyte --enable-gui=no \
"                 --with-x --enable-cscope \
"                 --with-compiledby="Vincent Driessen <vincent@datafox.nl>"
"
" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Editing behaviour {{{
filetype on                     " set filetype stuff to on
filetype plugin on
filetype indent on

set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                   " set show matching parenthesis
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set list                        " show invisible characters
set listchars=tab:»·,trail:·,extends:#,nbsp:·
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set showtabline=2               " show a tabbar on top, always
" }}}

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen,usetab    " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
                                " store swap files in one of these directories
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set modeline                    " allow files to include a 'mode line', to
                                "    override vim defaults
set modelines=5                 " check the first 5 lines for a modeline
" }}}

" Highlighting {{{
if &t_Co >= 256 || has("gui_running")
   colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
" }}}

" Shortcut mappings {{{
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, since we don't have to press that annoying Shift key that
" slows the commands down
nnoremap ; :

" don't use Ex mode, use Q for formatting
map Q gq

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Change the mapleader from \ to ,
let mapleader=","

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> ,d "_d
vmap <silent> ,d "_d

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Clears the search register
nmap ,/ :let @/=""<CR>

" Quick alignment of text
nmap ,al :left<CR>
nmap ,ar :right<CR>
nmap ,ac :center<CR>
" }}}

" Working with tabs {{{
set tabpagemax=10    " use at most 10 tabs
nmap ,t <Esc>:tabedit .<CR>
nmap ,T <Esc>:tabnew<CR>
nmap gt <C-w>gf
nmap gT <C-w>gF
nmap ,1 :tabn 1<CR>
nmap ,2 :tabn 2<CR>
nmap ,3 :tabn 3<CR>
nmap ,4 :tabn 4<CR>
nmap ,5 :tabn 5<CR>
nmap ,6 :tabn 6<CR>
nmap ,7 :tabn 7<CR>
nmap ,8 :tabn 8<CR>
nmap ,9 :tabn 9<CR>
nmap ,0 :tabn 10<CR>
nmap ,<Left> :tabprevious<CR>
nmap ,<Right> :tabnext<CR>
" }}}

" NERDTree settings {{{
" Put focus to the NERD Tree with F3 (tricked by quickly closing it and
" immediately showing it again, since there is no :NERDTreeFocus command)
nmap ,n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nmap ,m :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap ,N :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$' ]
" }}}

" TagList settings {{{
nmap ,l :TlistClose<CR>:TlistToggle<CR>
nmap ,L :TlistClose<CR>

" quit Vim when the TagList window is the last open window
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
"let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
"let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

" shorten the time it takes to highlight the current tag (default is 4 secs)
" note that this setting influences Vim's behaviour when saving swap files,
" but we have already turned off swap files (earlier)
"set updatetime=1000

" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1

" }}}

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" map 'gc' means goto conflict marker
" nmap <silent> gC /[<=>]\{7\}<CR>
nmap <silent> gC /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")

    augroup vim_files
        au!
        autocmd Filetype vim set expandtab    " disallow tabs in Vim files
    augroup end

   " in text files, always limit the width of text to 78 characters
   autocmd BufRead *.txt,*.tex,*.rst set textwidth=78

   " tabs in Python scripts are evil, so expand them to spaces
   autocmd BufRead *.py,*.rst set expandtab
   autocmd BufRead *.py,*.rst set number
   autocmd BufRead *.py set textwidth=78

   " highlight any line longer than 80 chars
   autocmd BufRead *.py,*.rst match ErrorMsg '\%>79v.\+'

   " highlight spaces in python
   autocmd BufRead *.py,*.rst set list
   autocmd BufRead *.py,*.rst set listchars=tab:»·,trail:·,extends:#

   " folding for Python (uses syntax/python.vim for fold definitions)
   autocmd BufRead *.py set nofoldenable
   autocmd BufRead *.py set foldmethod=expr

   " Python (test) runners:
   " - python    is ran with Ctrl-P, Ctrl-P ('p' for Python)
   " - ipython   is ran with Ctrl-P, Ctrl-I ('i' for iPython)
   " - nosetests is ran with Ctrl-P, Ctrl-N ('n' for Nose)
   " - test      is ran with Ctrl-P, Ctrl-T ('t' for test)
   "
   autocmd BufRead *.py map <C-p><C-p> :w<CR>:!python %<CR>
   autocmd BufRead *.py map <C-p><C-i> :w<CR>:!ipython %<CR>
   autocmd BufRead *.py map <C-p><C-n> :!(cd $(~/.vim/bin/projroot); nosetests)<CR>
   autocmd BufRead *.py map <C-p><C-t> :!(cd $(~/.vim/bin/projroot); python setup.py test)<CR>

   " Python static source checkers:
   " - pyflakes is ran with Ctrl-K, Ctrl-F ('f' for Flakes)
   " - pep8     is ran with Ctrl-K, Ctrl-P ('p' for PEP8)
   " - both     are ran with Ctrl-K, Ctrl-K (for the given file)
   " - both     are ran for all files in the project with Ctrl-K, Ctrl-A
   autocmd BufRead *.py map <C-k><C-f> :!pyflakes %<CR>
   autocmd BufRead *.py map <C-k><C-p> :!pep8 -r %<CR>
   autocmd BufRead *.py map <C-k><C-k> :!(pyflakes %; pep8 -r %)<CR>
   autocmd BufRead *.py map <C-k><C-a> :!find $(~/.vim/bin/projroot) -name '*.py' \| xargs pyflakes; find $(~/.vim/bin/projroot) -name '*.py' \| xargs pep8 -r<CR>

   " use closetag plugin to auto-close HTML tags
   autocmd Filetype html,xml,xsl source ~/.vim/scripts/html_autoclosetag.vim

   " bind <F1> to show the keyword under cursor
   " general help can still be entered manually, with :h
   autocmd Filetype vim noremap <F1> <Esc>:help <C-r><C-w><CR>
   autocmd Filetype vim noremap! <F1> <Esc>:help <C-r><C-w><CR>

endif " has("autocmd")
" }}}

" Auto save/restore {{{
au BufWritePost *.* silent mkview!
au BufReadPost *.* silent loadview

" Quick write session with F2
map <F2> :mksession! .vim_session<CR>
" And load session with F3
map <F3> :source .vim_session<CR>
" }}}

" Common abbreviations / misspellings {{{
source ~/.vim/autocorrect.vim
" }}}

" Extra vi-compatibility {{{
" set extra vi-compatible options
set cpoptions+=$     " when changing a line, don't redisplay, but put a '$' at
                     " the end during the change
set formatoptions-=o " don't start new lines w/ comment leader on pressing 'o'
au Filetype vim set formatoptions-=o
                     " somehow, during vim filetype detection, this gets set,
                     " so explicitly unset it again for vim files
" }}}

" Extra user or machine specific settings {{{
source ~/.vim/user.vim
" }}}
