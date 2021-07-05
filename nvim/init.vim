" Plugins ---------------------------------------------------------------- {{{

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'ElmCast/elm-vim'
Plug 'FooSoft/vim-argwrap'
Plug 'Lokaltog/vim-powerline'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'airblade/vim-gitgutter'
Plug 'alunny/pegjs-vim'
Plug 'bling/vim-bufferline'
Plug 'dag/vim-fish'
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mileszs/ack.vim'
Plug 'nvie/vim-align'
Plug 'nvie/vim-nox'
Plug 'nvie/vim-oceanic-next'
Plug 'nvie/vim-rule-of-law'
Plug 'othree/html5-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'ruanyl/vim-sort-imports'
Plug 'scrooloose/nerdtree'
Plug 'scy/vim-mkdir-on-write'
Plug 'terryma/vim-expand-region'
Plug 'tmhedberg/matchit' " Jump to matching paren with '%'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tsl0922/vim-nginx'
Plug 'vim-scripts/YankRing.vim'
Plug 'w0rp/ale'

" Perhaps no longer necessary now with neovim?
" Plug 'natebosch/vim-lsc'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete.vim'

" PYthon-related plugins
" Plug 'nvie/python-mode'
" Plug 'nvie/vim-flake8'

call plug#end()

" }}}


"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"
" My personally preferred version of vim is the one with the "big" feature
" set, in addition to the following configure options:
"
"     ./configure --with-features=BIG
"                 --enable-pythoninterp --enable-rubyinterp
"                 --enable-enablemultibyte --enable-gui=no --with-x --enable-cscope
"                 --with-compiledby="Vincent Driessen <vincent@datafox.nl>"
"                 --prefix=/usr
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

syntax on

" Change shell
set shell=bash                  " Vim expects a POSIX-compliant shell, which Fish (my default shell) is not

" Change the mapleader from \ to ,
let mapleader=","
let maplocalleader="\\"

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

set nrformats=                  " make <C-a> and <C-x> play well with
                                "    zero-padded numbers (i.e. don't consider
                                "    them octal or hex)

set shortmess+=I                " hide the launch screen
set clipboard=unnamed           " normal OS clipboard interaction
set autoread                    " automatically reload files changed outside of Vim

set updatetime=1000             " Speed up the updatetime so gitgutter and friends are quicker

" Make the keyboard faaaaaaast
set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=50

" Toggle show/hide invisible chars
nnoremap <leader>I :set list!<cr>

" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Triggers global-search-and-replace. Prompts for a replacement string and
" will replace all matches from the previous search command.
" nnoremap <leader>r :%s//
nnoremap <leader>r :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>:%s//

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>
" }}}

" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.config/nvim/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set nowritebackup               " do not write out changes via backup files
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.config/nvim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
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
set nomodeline                  " disable mode lines (security measure)
"set ttyfast                     " always use a fast terminal
set nocursorline                " don't highlight the current line (useful for quick orientation, but also slow to redraw)
" }}}

nnoremap <leader>, :set cursorline!<cr>  " toggle highlighting the cursor line

" Toggle the quickfix window {{{
" From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}

" Toggle the foldcolumn {{{
nnoremap <leader>f :call FoldColumnToggle()<cr>

let g:last_fold_column_width = 4  " Pick a sane default for the foldcolumn

function! FoldColumnToggle()
    if &foldcolumn
        let g:last_fold_column_width = &foldcolumn
        setlocal foldcolumn=0
    else
        let &l:foldcolumn = g:last_fold_column_width
    endif
endfunction
" }}}

" Highlighting {{{

if (has("termguicolors"))
   set termguicolors
endif

if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif

" }}}

" Shortcut mappings {{{
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, as I don't have to press the Shift key to form chords to
" enter ex mode.
nnoremap ; :
nnoremap <leader>; ;

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

nnoremap <leader>Q :q<CR>    " Quickly close the current window
nnoremap <leader>q :bd<CR>   " Quickly close the current buffer

" Use Q for formatting the current paragraph (or visual selection)
" This used to be `gq` and `gqap`, but the "w" variant is the same, but puts
" the cursor back at the original position after performing the
" transformation. See https://github.com/nvie/vimrc/issues/16
vnoremap Q gw
nnoremap Q gwap
" set breakindent on  " keep paragraph indentation when re-wrapping text

" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Shortcut to make
nnoremap mk :make<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Use the damn hjkl keys
" noremap <up> <nop>
" noremap <down> <nop>
" noremap <left> <nop>
" noremap <right> <nop>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" nnoremap <leader>w <C-w>v<C-w>l

" Complete whole filenames/lines with a quicker shortcut key in insert mode
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d
" vnoremap <silent> x "_x  TODODODOOo

" Quick yanking to the end of the line
nnoremap Y y$

" YankRing stuff
let g:yankring_history_dir = '$HOME/.config/nvim/.tmp'

" Edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Clears the search register
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nnoremap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n n:call PulseCursorLine()<cr>
nnoremap N N:call PulseCursorLine()<cr>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>

" Quick alignment of text
" nnoremap <leader>al :left<CR>
" nnoremap <leader>ar :right<CR>
" nnoremap <leader>ac :center<CR>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Ctrl+W to redraw the buffer's contents
"
" For some reason unclear to me, new files opened via the quickfix window
" (for example Flow errors triggered in unopened files) don't get
" their file types detected automatically.  For these new buffers, the
" filetype= (empty).
"
" This can be fixed by running
"
"     :filetype detect
"
" In those buffers, but this is super laborious.  This just plugs that
" under my existing "refresh the screen" shortcut <c-w>.
nnoremap <C-w> :filetype detect<cr>:redraw!<cr>

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Strip all trailing whitespace from a file, using ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Use The Silver Searcher over grep, iff possible
if executable('ag')
   " Use ag over grep
   set grepprg=ag\ --nogroup\ --nocolor
endif

" grep/Ack/Ag for the word under cursor
" vnoremap <leader>a y:grep! "\b<c-r>"\b"<cr>:cw<cr>
" nnoremap <leader>a :grep! "\b<c-r><c-w>\b"
vnoremap <leader>a y:Ag <c-r><cr>:cw<cr>
nnoremap <leader>a :Ag <c-r><c-w>
nnoremap K *N:grep! "\b<c-r><c-w>\b"<cr>:cw<cr>

" Allow quick additions to the spelling dict
nnoremap <leader>g :spellgood <c-r><c-w>

" Define "Ag" command
command -nargs=+ -complete=file -bar Ag silent! grep! <args> | cwindow | redraw!

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>

" Creating folds for tags in HTML
"nnoremap <leader>ft Vatzf

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]
" }}}

" NERDTree settings {{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nnoremap <leader>N :NERDTreeClose<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

" }}}

" vim-sort-imports config (import-sort fixer) {{{

" TODO: Ideally, this command would be run as an ALE fixer, so we can get rid
" of the vim-sort-imports plugin.
let g:import_sort_auto = 0

" }}}

" vim-flake8 default configuration
let g:flake8_show_in_gutter=0

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '\v^[<\|=|>]{7}([^=].+)?$'

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>c /\v^[<\|=>]{7}([^=].+)?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        " Auto-tidy selection
        vnoremap <leader>x :!tidy -q -i --show-errors 0 --show-body-only 1 --wrap 0<cr><cr>

        autocmd BufNewFile,BufRead *.html,*.htm,*.j2 call s:DetectHTMLVariant()
    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal textwidth=78
        autocmd filetype python match ErrorMsg '\%>120v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python inoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python noremap <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python inoremap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Automatic insertion of breakpoints
        autocmd filetype python nnoremap <buffer> <leader>bp :normal oimport pdb; pdb.set_trace()  # TODO: BREAKPOINT  # noqa<Esc>

        " Run a quick static syntax check every time we save a Python file
        " autocmd BufWritePost *.py call Flake8()

        " Defer to isort for sorting Python imports (instead of using Unix sort)
        autocmd filetype python nnoremap <leader>s mX:%!isort -<cr>`X:redraw!<cr>
    augroup end " }}}

    augroup js_files "{{{
        au!
        autocmd filetype javascript setlocal foldmethod=syntax
    augroup end " }}}

    augroup ts_files "{{{
        au!
        autocmd filetype typescript setlocal foldmethod=syntax
    augroup end " }}}

    augroup clojure_files "{{{
        au!

        " Set up <leader>r to run the entire file with vim-fireplace
        autocmd filetype clojure nnoremap <leader>r :%Eval<cr>
        autocmd filetype clojure RainbowParenthesesActivate
        autocmd filetype clojure RainbowParenthesesLoadRound
        autocmd filetype clojure RainbowParenthesesLoadSquare
        autocmd filetype clojure RainbowParenthesesLoadBraces
    augroup end " }}}

    augroup supervisord_files "{{{
        au!

        autocmd BufNewFile,BufRead supervisord.conf set ft=dosini
    augroup end " }}}

    augroup markdown_files "{{{
        au!

        autocmd filetype markdown noremap <buffer> <leader>p :w<CR>:!open -a 'Marked 2' %<CR><CR>
    augroup end " }}}

    augroup ruby_files "{{{
        au!

    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}

        " Enable insertion of "debugger" statement in JS files
        autocmd filetype javascript nnoremap <leader>b Odebugger; // eslint-disable-line<esc>

    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}

    augroup git_files "{{{
        au!

        " Don't remember the last cursor position when editing commit
        " messages, always start on line 1
        autocmd filetype gitcommit call setpos('.', [0, 1, 1, 0])
    augroup end "}}}
endif
" }}}

" Restore cursor position upon reopening files {{{
autocmd BufReadPost *
    \ if &filetype != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" }}}

" Common abbreviations / misspellings {{{
source ~/.config/nvim/autocorrect.vim
" }}}

" Extra vi-compatibility {{{
" set extra vi-compatible options
set cpoptions+=$     " when changing a line, don't redisplay, but put a '$' at
                     " the end during the change
set formatoptions-=o " don't start new lines w/ comment leader on pressing 'o'
au filetype vim set formatoptions-=o
                     " somehow, during vim filetype detection, this gets set
                     " for vim files, so explicitly unset it again
au filetype crontab setlocal backupcopy=yes
                     " editing crontab files needs to happen in-place
" }}}

" Creating underline/overline headings for markup languages
" Inspired by http://sphinx.pocoo.org/rest.html#sections
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

" Smart-quote a paragraph
vnoremap ' :s/'/’/<cr>

"set guifont=Anonymous\ for\ Powerline:h12 linespace=2
"set guifont=Droid\ Sans\ Mono:h14 linespace=0
"set guifont=Mensch\ for\ Powerline:h14 linespace=0
"set guifont=saxMono:h14 linespace=3
"set guifont=Ubuntu\ Mono:h18 linespace=3
set guifont=Source\ Code\ Pro\ Light:h10 linespace=0

if has("gui_running")
    " Remove toolbar, left scrollbar and right scrollbar
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guifont=Source\ Code\ Pro\ Light:h13 linespace=0
else
    set bg=dark
endif

colorscheme OceanicNext

" Pulse ------------------------------------------------------------------- {{{

function! PulseCursorLine()
    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 14m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 10m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 14m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 10m

    execute 'hi ' . old_hi
    setlocal nocursorline
endfunction

" }}}

" Powerline configuration ------------------------------------------------- {{{

let g:Powerline_symbols = 'compatible'
"let g:Powerline_symbols = 'fancy'

" }}}

" Python mode configuration ----------------------------------------------- {{{

" Don't run pylint on every save
let g:pymode = 1
let g:pymode_breakpoint = 0
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_doc = 0
let g:pymode_doc_bind = 'K'
let g:pymode_folding = 0
let g:pymode_indent = 0
let g:pymode_lint = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_cwindow = 1
let g:pymode_lint_ignore = ''
let g:pymode_lint_message = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_select = ''
let g:pymode_lint_signs = 1
let g:pymode_motion = 0
let g:pymode_options = 0
let g:pymode_paths = []
let g:pymode_quickfix_maxheight = 6
let g:pymode_quickfix_minheight = 3
let g:pymode_rope = 1
let g:pymode_rope_completion = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_run = 0
let g:pymode_run_bind = '<leader>r'
let g:pymode_trim_whitespaces = 0

" }}}

" JavaScript configuration ------------------------------------------------ {{{

let g:javascript_plugin_jsdoc = 0
let g:javascript_plugin_flow = 1

" See https://github.com/elzr/vim-json#specific-customizations
let g:vim_json_syntax_conceal = 0

" }}}

" fzf config -------------------------------------------------------------- {{{

" Invoke fzf, but CommandT style
nnoremap <leader>t :Files<cr>
nnoremap <leader>. :Tags<cr>
nnoremap <leader>b :Buffers<cr>

" ------------------------------------------------------------------------- }}}

" Learn Vim Script the Hard Way Exercises
"noremap - ddp
"noremap _ ddkP

" C-U in insert/normal mode, to uppercase the word under cursor
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l

" Quote current selection
" TODO: This only works for selections that are created "forwardly"
vnoremap <leader>" <esc>a"<esc>gvo<esc>i"<esc>gvo<esc>ll
vnoremap <leader>' <esc>a'<esc>gvo<esc>i'<esc>gvo<esc>ll

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $

" Define operator-pending mappings to quickly apply commands to function names
" and/or parameter lists in the current line
onoremap inf :<c-u>normal! 0f(hviw<cr>
onoremap anf :<c-u>normal! 0f(hvaw<cr>
onoremap in( :<c-u>normal! 0f(vi(<cr>
onoremap an( :<c-u>normal! 0f(va(<cr>

" "Next" tag
onoremap int :<c-u>normal! 0f<vit<cr>
onoremap ant :<c-u>normal! 0f<vat<cr>

" Function argument selection (change "around argument", change "inside argument")
onoremap ia :<c-u>execute "normal! ?[,(]\rwv/[),]\rh"<cr>
vnoremap ia :<c-u>execute "normal! ?[,(]\rwv/[),]\rh"<cr>

" Split previously opened file ('#') in a split window
nnoremap <leader>sh :execute "leftabove vsplit" bufname('#')<cr>
nnoremap <leader>sl :execute "rightbelow vsplit" bufname('#')<cr>

" Grep searches
"nnoremap <leader>g :silent execute "grep! -R " . shellescape('<cword>') . " ."<cr>:copen 12<cr>
"nnoremap <leader>G :silent execute "grep! -R " . shellescape('<cWORD>') . " ."<cr>:copen 12<cr>

" Rope config
nnoremap <leader>A :RopeAutoImport<cr>

" Switch from block-cursor to vertical-line-cursor when going into/out of
" insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Configure vim-expand-region, for easy selection precision {{{

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
   \ 'iw'  : 0,
   \ 'i"'  : 1,
   \ 'i''' : 1,
   \ 'a"'  : 0,
   \ 'a''' : 0,
   \ 'i)'  : 1,
   \ 'i}'  : 1,
   \ 'i]'  : 1,
   \ 'a)'  : 1,
   \ 'a}'  : 1,
   \ 'a]'  : 1,
   \ }

" }}}

" Configure ArgWrap
let g:argwrap_tail_comma = 1
nnoremap <leader>w :ArgWrap<cr>

" ALE config {{{

" let g:ale_enabled = 1
let g:ale_completion_enabled = 0
let g:ale_lint_delay = 200   " millisecs
" let g:ale_lint_on_text_changed = 'always'  " never/insert/normal/always
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" let g:ale_open_list = 1

" TODO: Temporary hack until our eslint is configured correctly
" let g:ale_javascript_eslint_options = '--no-ignore --rulesdir eslint'

let g:ale_linters = {
\   'graphql': ['eslint', 'flow'],
\   'javascript.jsx': ['eslint', 'flow'],
\   'javascript': ['eslint', 'flow'],
\   'typescriptreact': ['typescript'],
\   'typescript': ['typescript'],
\}
let g:ale_fixers = {
\   'graphql': ['eslint', 'prettier'],
\   'javascript.jsx': ['eslint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'markdown': ['prettier'],
\   'pegjs': ['prettier'],
\}

" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" }}}

" {{{ Check JS with Flow

" Uncomment this if it gets annoying
" let g:asyncomplete_auto_popup = 0
" let g:asyncomplete_remove_duplicates = 1

" Tab completion for vim-lsp
" inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
"inoremap <tab> <c-n>
"inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
"inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
"set completeopt=menu,longest,preview

" Force refresh completion
"imap <s-space> <Plug>(asyncomplete_force_refresh)

" vim-lsp configuration for IDE-like Flow help
" See https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Flow
"if executable('flow-language-server')
"   nnoremap gd :LspDefinition<cr>
"   nnoremap <leader>i :LspHover<cr>
"   autocmd FileType javascript setlocal omnifunc=lsp#complete
"   autocmd FileType javascript.jsx setlocal omnifunc=lsp#complete
"
"   au User lsp_setup call lsp#register_server({
"      \ 'name': 'flow-language-server',
"      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'flow-language-server --stdio']},
"      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
"      \ 'whitelist': ['javascript', 'javascript.jsx'],
"      \ })
"endif

" }}}

" {{{ Check JS with Flow (vim-lsc)

" inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <tab> <c-n>
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

let g:lsc_server_commands = {
   \ 'javascript': 'flow lsp',
   \ 'typescript': 'typescript-language-server --stdio',
   \ 'typescriptreact': 'typescript-language-server --stdio',
   \ }

" Use all the defaults (recommended)
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': '<leader>i',
 \  'Completion': 'omnifunc',
 \}

let g:lsc_preview_split_direction = 'below'
let g:lsc_enable_autocomplete  = v:true
let b:vcm_tab_complete = "omni"

" Apply the defaults with a few overrides:
"let g:lsc_auto_map = {'defaults': v:true, 'FindReferences': '<leader>r'}

" Setting a value to a blank string leaves that command unmapped:
"let g:lsc_auto_map = {'defaults': v:true, 'FindImplementations': ''}

" ... or set only the commands you want mapped without defaults.
" Complete default mappings are:
"let g:lsc_auto_map = {
"   \ 'GoToDefinition': '<C-]>',
"   \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
"   \ 'FindReferences': 'gr',
"   \ 'NextReference': '<C-n>',
"   \ 'PreviousReference': '<C-p>',
"   \ 'FindImplementations': 'gI',
"   \ 'FindCodeActions': 'ga',
"   \ 'Rename': 'gR',
"   \ 'ShowHover': v:true,
"   \ 'DocumentSymbol': 'go',
"   \ 'WorkspaceSymbol': 'gS',
"   \ 'SignatureHelp': 'gm',
"   \ 'Completion': 'completefunc',
"   \}

" }}}

" Elm!
let g:elm_format_autosave = 1

" Switch.vim! {{{

let g:switch_mapping = "!"
let g:switch_custom_definitions =
  \ [
  \   {
  \     'x\(\d\*\)\?': 'y\1',
  \     'y\(\d\*\)\?': 'x\1',
  \   },
  \   ['width', 'height'],
  \ ]

autocmd FileType gitrebase let b:switch_custom_definitions =
   \ [
   \   ['pick', 'fixup', 'squash', 'reword', 'edit', 'exec']
   \ ]

" }}}


" Helper to display the current syntax highlighting group under cursor {{{

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>

" }}}

" Convert current filename to the clipboard
" ,cs = copy short name (relative path)
" ,cl = copy long name  (fully expanded absolute path)
nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>
