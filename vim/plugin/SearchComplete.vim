" SearchComplete.vim
" Author: Chris Russell
" Version: 1.1
" License: GPL v2.0 
" 
" Description:
" This script defineds functions and key mappings for Tab completion in 
" searches.
" 
" Help:
" This script catches the <Tab> character when using the '/' search 
" command.  Pressing Tab will expand the current partial word to the 
" next matching word starting with the partial word.
" 
" If you want to match a tab, use the '\t' pattern.
"
" Installation:
" Simply drop this file into your $HOME/.vim/plugin directory.
" 
" Changelog:
" 2002-11-08 v1.1
" 	Convert to unix eol
" 2002-11-05 v1.0
" 	Initial release
" 
" TODO:
" 


"--------------------------------------------------
" Avoid multiple sourcing
"-------------------------------------------------- 
if exists( "loaded_search_complete" )
    finish
endif
let loaded_search_complete = 1


"--------------------------------------------------
" Key mappings
"-------------------------------------------------- 
noremap / :call SearchCompleteStart()<CR>/


"--------------------------------------------------
" Set mappings for search complete
"-------------------------------------------------- 
function! SearchCompleteStart()
	cnoremap <Tab> <C-C>:call SearchComplete()<CR>/<C-R>s
	cnoremap <silent> <CR> <CR>:call SearchCompleteStop()<CR>
	cnoremap <silent> <Esc> <C-C>:call SearchCompleteStop()<CR>
endfunction

"--------------------------------------------------
" Tab completion in / search
"-------------------------------------------------- 
function! SearchComplete()
	" get current cursor position
	let l:loc = col( "." ) - 1
	" get partial search and delete
	let l:search = histget( '/', -1 )
	call histdel( '/', -1 )
	" check if new search
	if l:search == @s
		" get root search string
		let l:search = b:searchcomplete
		" increase number of autocompletes
		let b:searchcompletedepth = b:searchcompletedepth . "\<C-N>"
	else
		" one autocomplete
		let b:searchcompletedepth = "\<C-N>"
	endif
	" store origional search parameter
	let b:searchcomplete = l:search
	" set paste option to disable indent options
	let l:paste = &paste
	setlocal paste
	" on a temporary line put search string and use autocomplete
	execute "normal! A\n" . l:search . b:searchcompletedepth
	" get autocomplete result
	let @s = getline( line( "." ) )
	" undo and return to first char
	execute "normal! u0"
	" return to cursor position
	if l:loc > 0
		execute "normal! ". l:loc . "l"
	endif
	" reset paste option
	let &paste = l:paste
endfunction

"--------------------------------------------------
" Remove search complete mappings
"-------------------------------------------------- 
function! SearchCompleteStop()
	cunmap <Tab>
	cunmap <CR>
	cunmap <Esc>
endfunction

