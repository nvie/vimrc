"
" Python Unit Testing Support
" by Mike Crute (mcrute@gmail.com)
"
" Shamelessly ripped off of Gary Bernhart
"

" Unit Test Functions {{{
set errorformat=%f:%l:\ fail:\ %m,%f:%l:\ error:\ %m
set makeprg=nosetests\ -q\ --with-machineout

function! RedBar()
    hi RedBar ctermfg=white ctermbg=red guibg=red
    echohl RedBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! GreenBar()
    hi GreenBar ctermfg=white ctermbg=green guibg=green
    echohl GreenBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction
" }}}
" {{{ Testing Support 
let g:show_tests = 0

function! ClassToFilename(class_name)
    let understored_class_name = substitute(a:class_name, '\(.\)\(\u\)', '\1_\U\2', 'g')
    let file_name = substitute(understored_class_name, '\(\u\)', '\L\1', 'g')
    return 'test_' . file_name . '.py'
endfunction

function! NameOfCurrentClass()
    let save_cursor = getpos(".")
    normal $<cr>
    call PythonDec('class', -1)
    let line = getline('.')
    call setpos('.', save_cursor)
    let match_result = matchlist(line, ' *class \+\(\w\+\)')
    return match_result[1]
endfunction

function! ModuleTestPath()
    let file_path = @%
    let components = split(file_path, '/')
    let filename = remove(components, -1)
    let components = add(components, 'tests')
    let test_path = join(components, '/')
    return test_path
endfunction

function! TestFileForCurrentClass()
    let class_name = NameOfCurrentClass()
    let test_file_name = ModuleTestPath() . '/' . ClassToFilename(class_name)
    return test_file_name
endfunction

function! TestFileForCurrentFile()
    let filename = split(@%, '/')[-1]
    let module_path = ModuleTestPath()
    let components = split(module_path, '/')
    let components = add(components, 'test_' . filename)
    return join(components, '/')
endfunction

function! RunTests(target, args)
    silent ! echo
    exec 'silent ! echo -e "\033[1;36mRunning tests in ' . a:target . '\033[0m"'
    set makeprg=nosetests
    silent w
    exec "make! " . a:target . " " . a:args
endfunction

function! RunTestsForFile(args)
    if @% =~ 'test_'
        call RunTests('%', a:args)
    else
        let test_file_name = TestFileForCurrentFile()
        call RunTests(test_file_name, a:args)
    endif
endfunction

function! RunAllTests(args)
    silent ! echo
    silent ! echo -e "\033[1;36mRunning all unit tests\033[0m"
    set makeprg=nosetests
    silent w
    exec "make! tests.unit " . a:args
endfunction

function! JumpToError()
    if getqflist() != []
        for error in getqflist()
            if error['valid']
                break
            endif
        endfor
        let error_message = substitute(error['text'], '^ *', '', 'g')
        " silent cc!
        let error_buffer = error['bufnr']
        if g:show_tests == 1
            exec ":vs"
            exec ":buffer " . error_buffer
        endif
        exec "normal ".error['lnum']."G"
        call RedBar()
        echo error_message
    else
        call GreenBar()
        echo "All tests passed"
    endif
endfunction

function! JumpToTestsForClass()
    exec 'e ' . TestFileForCurrentClass()
endfunction
" }}}

" Keyboard mappings {{{
nnoremap <leader>m :call RunTestsForFile('-q --with-machineout')<cr>:redraw<cr>:call JumpToError()<cr>
nnoremap <leader>M :call RunTestsForFile('')<cr>
nnoremap <leader>a :call RunAllTests('-q --with-machineout')<cr>:redraw<cr>:call JumpToError()<cr>
nnoremap <leader>A :call RunAllTests('')<cr>
nnoremap <leader>t :call JumpToTestsForClass()<cr>
nnoremap <leader><leader> <c-^>
" }}}
