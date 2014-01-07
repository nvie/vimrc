if exists('g:loaded_bufferline')
  finish
endif
let g:loaded_bufferline = 1

function! s:check_defined(variable, default)
  if !exists(a:variable)
    let {a:variable} = a:default
  endif
endfunction

call s:check_defined('g:bufferline_active_buffer_left', '[')
call s:check_defined('g:bufferline_active_buffer_right', ']')
call s:check_defined('g:bufferline_separator', ' ')
call s:check_defined('g:bufferline_modified', '+')
call s:check_defined('g:bufferline_echo', 1)
call s:check_defined('g:bufferline_show_bufnr', 1)
call s:check_defined('g:bufferline_fname_mod', ':t')
call s:check_defined('g:bufferline_inactive_highlight', 'StatusLineNC')
call s:check_defined('g:bufferline_active_highlight', 'StatusLine')
call s:check_defined('g:bufferline_rotate', 0)
call s:check_defined('g:bufferline_fixed_index', 1)
call s:check_defined('g:bufferline_solo_highlight', 0)
call s:check_defined('g:bufferline_excludes', ['\[vimfiler\]'])

function! bufferline#generate_string()
  return "bufferline#generate_string() is obsolete! Please consult README."
endfunction

let g:bufferline_status_info = {
      \ 'count': 0,
      \ 'before': '',
      \ 'current': '',
      \ 'after': '',
      \ }

function! bufferline#refresh_status()
  if g:bufferline_solo_highlight
    if g:bufferline_status_info.count == 1
      exec printf('highlight! link %s %s', g:bufferline_active_highlight, g:bufferline_inactive_highlight)
    else
      exec printf('highlight! link %s NONE', g:bufferline_active_highlight)
    endif
  endif
  call bufferline#get_echo_string()
  return ''
endfunction
function! bufferline#get_status_string()
  return
        \ '%#'.g:bufferline_inactive_highlight.'#'
        \.'%{g:bufferline_status_info.before}'
        \.'%#'.g:bufferline_active_highlight.'#'
        \.' %{g:bufferline_status_info.current} '
        \.'%#'.g:bufferline_inactive_highlight.'#'
        \.'%{g:bufferline_status_info.after}'
endfunction

if g:bufferline_echo
  call bufferline#init_echo()
endif
