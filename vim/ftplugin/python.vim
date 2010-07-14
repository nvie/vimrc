" FILE:     python.vim
" AUTHOR:   David Morris
" PURPOSE:  Add syntax folding to python source code

source $VIMRUNTIME/syntax/python.vim

setlocal foldexpr=GetPyFold(v:lnum)
let g:cind = 0
let g:ctyp = 0
let g:ccmt = 0

function! GetPyFold(lnum)
    while 1 == 1
        " Determine the current folding level
        let line=getline(a:lnum)
        let cind=indent(a:lnum)

        " Get the next non-blank line
        let nnum  = nextnonblank(a:lnum + 1)
        let nind  = indent(nnum)
        let nline = getline(nnum)

        " Get the previous non-blank line
        let pnum = prevnonblank(a:lnum - 1)

        " Get the previous line indent level
        let plvlnum = a:lnum - 1
        let lvl = foldlevel(plvlnum)

        " If the previous non-blank line is the start of the file,
        " we are not in a fold
        if pnum == 0
            let retStr =  0
            break
        endif

        " If there are no more non-blank lines, the fold should end
        if nnum == 0
            let retStr =  0
            break
        endif

        " Blank lines always get the same fold level as the previous line
        if line =~ '^\s*$'
            let retStr =  "="
            break
        endif

        " Check for the beginning of a multi-line comment
        if line =~ '"""' && line !~ '""".*"""'
                \ || line =~ "'''" && line !~ "'''.*'''"
            if g:ccmt == 0
                let g:ccmt = 1
            else
                let g:ccmt = 0
            endif
        endif

        if g:ccmt == 0
            " Always create the beginning of a new fold for all classes and
            " functions
            if line =~ '^\s*\(class\|def\)\s'
                let retStr =  ">" . (cind / &sw + 1)
                if g:ctyp > (cind / &sw + 1) && g:cind == cind
                    let g:ctyp = (cind / &sw + 1)
                endif
                let g:cind = cind
                let g:ctyp = g:ctyp + 1
                break
            endif


            if nind == g:cind && g:ctyp > 0
                if nline =~ '^\s*#\s*end\s*\<\(class\|def\)\>'
                    let retStr = "="
                    break
                endif
            endif

            if cind == g:cind && g:ctyp > 0
                if line =~ '^\s*#\s*end\s*\<\(class\|def\)\>'
                    let retStr = "<" . (cind / &sw + 1)
                    let g:cind = cind
                    let g:ctyp = (cind / &sw + 1)
                    break
                endif
            endif

            if nind <= g:cind && g:ctyp > 0
                let retStr =  "<" . (nind / &sw + 1)
                let g:ctyp = (nind / &sw + 1)
                let g:cind = nind
                break
            endif
        endif

        let retStr =  "="
        break
    endwhile
    "echon a:lnum " " ":" a:lnum " " nnum " " g:ctyp " : " retStr " : " line "\n"
    "echon g:cind " " cind " " nind " " g:ctyp " : " retStr " : " line "\n"
    "echon g:ccmt " : " retStr " : " line "\n"
    return retStr
endfunction

