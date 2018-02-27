" keep track of vimrc setting
let s:updatetime = &updatetime

" keep track of scrollinf window start
let s:window_start = 0

function! s:generate_names()
  let names = []
  let i = 1
  let last_buffer = bufnr('$')
  let current_buffer = bufnr('%')
  while i <= last_buffer
    if bufexists(i) && buflisted(i)
      let modified = ' '
      if getbufvar(i, '&mod')
        let modified = g:bufferline_modified
      endif
      let fname = fnamemodify(bufname(i), g:bufferline_fname_mod)
      let fname = substitute(fname, "%", "%%", "g")

      let skip = 0
      for ex in g:bufferline_excludes
        if match(fname, ex) > -1
          let skip = 1
          break
        endif
      endfor

      if !skip
        let name = ''
        if g:bufferline_show_bufnr != 0 && g:bufferline_status_info.count >= g:bufferline_show_bufnr
          let name =  i . ':'
        endif
        let name .= fname . modified

        if current_buffer == i
          let name = g:bufferline_active_buffer_left . name . g:bufferline_active_buffer_right
          let g:bufferline_status_info.current = name
        else
          let name = g:bufferline_separator . name . g:bufferline_separator
        endif

        call add(names, [i, name])
      endif
    endif
    let i += 1
  endwhile

  if len(names) > 1
    if g:bufferline_rotate == 1
      call bufferline#algos#fixed_position#modify(names)
    endif
  endif

  return names
endfunction

function! bufferline#get_echo_string()
  " check for special cases like help files
  let current = bufnr('%')
  if !bufexists(current) || !buflisted(current)
    return bufname('%')
  endif

  let names = s:generate_names()
  let line = ''
  for val in names
    let line .= val[1]
  endfor

  let index = match(line, '\V'.g:bufferline_status_info.current)
  let g:bufferline_status_info.count = len(names)
  let g:bufferline_status_info.before = strpart(line, 0, index)
  let g:bufferline_status_info.after = strpart(line, index + len(g:bufferline_status_info.current))
  return line
endfunction

function! s:echo()
  let line = bufferline#get_echo_string()

  " 12 is magical and is the threshold for when it doesn't wrap text anymore
  let width = &columns - 12
  if g:bufferline_rotate == 2
    let current_buffer_start = stridx(line, g:bufferline_active_buffer_left)
    let current_buffer_end = stridx(line, g:bufferline_active_buffer_right)
    if current_buffer_start < s:window_start
      let s:window_start = current_buffer_start
    endif
    if current_buffer_end > (s:window_start + width)
      let s:window_start = current_buffer_end - width + 1
    endif
    let line = strpart(line, s:window_start, width)
  else
    let line = strpart(line, 0, width)
  endif

  echo line

  if &updatetime != s:updatetime
    let &updatetime = s:updatetime
  endif
endfunction

function! s:cursorhold_callback()
  call s:echo()
  autocmd! bufferline CursorHold
endfunction

function! s:refresh(updatetime)
  let &updatetime = a:updatetime
  autocmd bufferline CursorHold * call s:cursorhold_callback()
endfunction

function! bufferline#init_echo()
  augroup bufferline
    au!

    " events which output a message which should be immediately overwritten
    autocmd BufWinEnter,WinEnter,InsertLeave,VimResized * call s:refresh(1)
  augroup END

  autocmd CursorHold * call s:echo()
endfunction
