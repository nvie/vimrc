" Example .vimrc file
" Maintained by Bram Molenaar
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set nowrap		 		 " don't wrap lines (use set wrap to turn wrapping on)
set ts=4		 		 " a tab is four spaces
set bs=2		 		 " allow backspacing over everything in insert mode
set ai		 		 		 " always set autoindenting on
set ignorecase		 		 " ignore case when searching
set nobackup		 		 " do not keep a backup file, use versions instead
set viminfo='20,\"50		 " read/write a .viminfo file, don't store more
		 		 		 " than 50 lines of registers
set ruler		 		 " show the cursor position all the time
set hlsearch		 	 " highlight search terms

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78
 autocmd BufRead *.tex set tw=78

 " A tab in our Python scripts is evil, so expand them to spaces
 autocmd BufRead *.py set ts=4
 autocmd BufRead *.py set expandtab
 autocmd BufRead *.py set number
 autocmd BufRead *.py set tw=72

 " For mails by mutt: use the 72th column for wrapping
 autocmd BufRead mutt* set tw=72

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  " set binary mode before reading the file
  autocmd BufReadPre,FileReadPre		 *.gz,*.bz2 set bin
  autocmd BufReadPost,FileReadPost		 *.gz call GZIP_read("gunzip")
  autocmd BufReadPost,FileReadPost		 *.bz2 call GZIP_read("bunzip2")
  autocmd BufWritePost,FileWritePost		 *.gz call GZIP_write("gzip")
  autocmd BufWritePost,FileWritePost		 *.bz2 call GZIP_write("bzip2")
  autocmd FileAppendPre		 		 		 *.gz call GZIP_appre("gunzip")
  autocmd FileAppendPre		 		 		 *.bz2 call GZIP_appre("bunzip2")
  autocmd FileAppendPost		 		 *.gz call GZIP_write("gzip")
  autocmd FileAppendPost		 		 *.bz2 call GZIP_write("bzip2")

  " After reading compressed file: Uncompress text in buffer with "cmd"
  fun! GZIP_read(cmd)
    " set 'cmdheight' to two, to avoid the hit-return prompt
    let ch_save = &ch
    set ch=3
    " when filtering the whole buffer, it will become empty
    let empty = line("'[") == 1 && line("']") == line("$")
    let tmp = tempname()
    let tmpe = tmp . "." . expand("<afile>:e")
    " write the just read lines to a temp file "'[,']w tmp.gz"
    execute "'[,']w " . tmpe
    " uncompress the temp file "!gunzip tmp.gz"
    execute "!" . a:cmd . " " . tmpe
    " delete the compressed lines
    '[,']d
    " read in the uncompressed lines "'[-1r tmp"
    set nobin
    execute "'[-1r " . tmp
    " if buffer became empty, delete trailing blank line
    if empty
      normal Gdd''
    endif
    " delete the temp file
    call delete(tmp)
    let &ch = ch_save
    " When uncompressed the whole buffer, do autocommands
    if empty
      execute ":doautocmd BufReadPost " . expand("%:r")
    endif
  endfun

  " After writing compressed file: Compress written file with "cmd"
  fun! GZIP_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "!" . a:cmd . " <afile>:r"
    endif
  endfun

  " Before appending to compressed file: Uncompress file with "cmd"
  fun! GZIP_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")

" Set vi-compatible options
set cpo=aABceFs$

" Set show matching parenthesis
set showmatch

" Perfrom some custom highlighting
highlight comment ctermfg=yellow

" Support local .exrc files
set exrc

" Map Ctrl+TAB and Ctrl+Shift+TAB keys to cycle through buffers
nnoremap <C-Tab> :bnext<CR>
nnoremap <S-C-Tab> :bprevious<CR>

" Auto save/restore views for all files (*)
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Run Python files by pressing F5
" Run Jython files by pressing F6
map <f5> :w<CR>:!python %<CR>
map <f7> :w<CR>:!./%<CR>
