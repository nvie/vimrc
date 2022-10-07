function! neoformat#formatters#pegjs#enabled() abort
    return ['prettier']
endfunction

function! neoformat#formatters#pegjs#prettier() abort
    return {
       \ 'exe': 'prettier',
       \ 'args': ['--stdin-filepath', '"%:p"'],
       \ 'stdin': 1
       \ }
endfunction
