" ------------------------------------------------------------------------
" NOTE: The following hack is necessary to get a change to detect the file
" type of *.rules files _before_ Vim does it for us (and concludes that
" they're Hog files).
"
" This could be removed once vim-rule-of-law knows how to override this from
" a plugin.

if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect

    " Ignore filetypes for *.rules files
    autocmd! BufNewFile,BufRead *.rules setfiletype rule-of-law

augroup END

" ------------------------------------------------------------------------
