" pins the active buffer to a specific index in the list
function! bufferline#algos#fixed_position#modify(names)
  let current = bufnr('%')
  while a:names[g:bufferline_fixed_index][0] != current
    let first = remove(a:names, 0)
    call add(a:names, first)
  endwhile
endfunction

