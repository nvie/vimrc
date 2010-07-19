function <SID>Pep8()
  set lazyredraw
  " Close any existing cwindows.
  cclose
  let l:grepformat_save = &grepformat
  let l:grepprogram_save = &grepprg
  set grepformat&vim
  set grepformat&vim
  let &grepformat = '%f:%l:%m'
  let &grepprg = 'pep8 --repeat'
  if &readonly == 0 | update | endif
  silent! grep! %
  let &grepformat = l:grepformat_save
  let &grepprg = l:grepprogram_save
  let l:mod_total = 0
  let l:win_count = 1
  " Determine correct window height
  windo let l:win_count = l:win_count + 1
  if l:win_count <= 2 | let l:win_count = 4 | endif
  windo let l:mod_total = l:mod_total + winheight(0)/l:win_count |
        \ execute 'resize +'.l:mod_total
  " Open cwindow
  execute 'belowright copen '.l:mod_total
  nnoremap <buffer> <silent> c :cclose<CR>
  nnoremap <buffer> <silent> q :cclose<CR>
  set nolazyredraw
  redraw!
endfunction

if ( !hasmapto('<SID>Pep8()') && (maparg('<F5>') == '') )
  map <F5> :call <SID>Pep8()<CR>
  map! <F5> :call <SID>Pep8()<CR>
else
  if ( !has("gui_running") || has("win32") )
    echo "Python PEP8 Error: No Key mapped.\n".
          \ "<F5> is taken and a replacement was not assigned."
  endif
endif

