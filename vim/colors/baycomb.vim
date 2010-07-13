" Vim color file
" baycomb v1.8b
" http://www.vim.org/scripts/script.php?script_id=1454
" 
" Maintainer:	Shawn Axsom <axs221@gmail.com>
"
"   * Place :colo baycomb in your VimRC/GVimRC file
"     * GvimRC if using GUI any
"
"   - Thanks to Desert and OceanDeep for their color scheme 
"     file layouts
"   - Thanks to Raimon Grau for his feedback

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
		syntax reset
    endif
endif

let g:colors_name="baycomb"

hi Normal       guifg=#b5c5f0 guibg=#11111a   "1a1823
hi NonText      guifg=#382920 guibg=bg

hi Folded       guibg=#1b182f guifg=#BBDDCC
hi FoldColumn	guibg=#00060a guifg=#dbcaa5
hi LineNr       guibg=#000000 guifg=#506389 
hi StatusLine	guibg=#4b4a5d guifg=#00a0f0 gui=none
hi StatusLineNC	guibg=#454050 guifg=#6c8dbe gui=none
hi VertSplit	guibg=#222535 guifg=#223355  gui=none

hi tablinesel   guibg=#515a71 guifg=#50aae5 gui=none
hi tabline      guibg=#4d4d5f guifg=#5b7098 gui=none
hi tablinefill  guibg=#2d2d3f guifg=#aaaaaa gui=none

" syntax highlighting """"""""""""""""""""""""""""""""""""""""

"set comments to grey on non-Windows OS's to make sure
"it is readable
if &term == "builtin_gui" || &term == "win32"
	hi Comment		guifg=darkgrey  guibg=#2a233a
else
	hi Comment		guifg=grey  guibg=#2a233a
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi Title	    guifg=#e5e5ca gui=none
hi Underlined   guifg=#cad5ca gui=none

hi Statement    guifg=#e57a78 gui=none
hi Type		    guifg=#8380c8 gui=none
hi Constant	    guifg=#6595e0 "guibg=#111a2a
hi Number       guifg=#3d95f0 "guibg=#111a2a
hi PreProc      guifg=#9a65ff
hi Special	    guifg=#9a9aaa
hi Ignore       guifg=grey40
hi Todo		    guifg=orangered guibg=yellow2
hi Error        guibg=#b03452
hi Function     guifg=#c09aaa guibg=bg gui=None 
hi Identifier   guifg=#9090b0   
"""""this section borrowed from OceanDeep/Midnight"""""
highlight Conditional gui=None guifg=#ba405a guibg=bg
highlight Repeat gui=None guifg=#e03d5a guibg=bg
"hi Label gui=None guifg=LightGreen guibg=bg
highlight Operator gui=None guifg=#baaa55 guibg=bg
highlight Keyword gui=bold guifg=grey guibg=bg
highlight Exception gui=none guifg=#ea5460 guibg=bg
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"end syntax highlighting """""""""""""""""""""""""""""""""""""

" highlight groups
"hi CursorIM
hi Directory	guifg=#bbd0df
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
hi ErrorMsg     guibg=#ff4545

hi Cursor       guibg=#cad5c0 guifg=#05293d


hi Search       guibg=#808373 guifg=#3a4520
hi IncSearch	guifg=#babeaa guibg=#3a4520 

hi ModeMsg    	guifg=#00AACC
hi MoreMsg      guifg=SeaGreen
hi Question    	guifg=#AABBCC
hi SpecialKey	guifg=#90dcb0
hi Visual       guifg=#102030 guibg=#80a0f0
hi VisualNOS    guifg=#201a30 guibg=#a3a5FF
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar  guibg=grey30 guifg=tan
"hi Tooltip


" new Vim 7.0 items
hi Pmenu        guibg=#3a6595 guifg=#9aadd5
hi PmenuSel     guibg=#4a85ba guifg=#b0d0f0                    





" color terminal definitions
hi Normal ctermfg=grey
hi Number ctermfg=blue
highlight Operator ctermfg=yellow
highlight Conditional ctermfg=darkred
highlight Repeat ctermfg=darkred
hi Exception ctermfg=red
hi function ctermfg=darkyellow
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=darkgrey
hi Directory	ctermfg=darkcyan
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	ctermfg=yellow ctermbg=darkyellow cterm=NONE
hi Search	ctermfg=black ctermbg=darkyellow cterm=NONE
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=darkcyan ctermbg=NONE
hi Question	ctermfg=green
hi StatusLine	ctermfg=blue ctermbg=grey cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=grey cterm=NONE
hi VertSplit	ctermfg=black ctermbg=grey cterm=NONE
hi Title	ctermfg=Yellow cterm=NONE
hi Visual	ctermbg=darkcyan ctermfg=black cterm=NONE
hi VisualNOS	ctermbg=darkcyan ctermfg=black cterm=NONE
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgreen ctermbg=NONE cterm=NONE
hi FoldColumn	ctermfg=green ctermbg=black
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi identifier   ctermfg=darkmagenta

"set comments to grey on non-Windows OS's to make sure
"it is readable
if &term == "builtin_gui" || &term == "win32"
	hi Comment		ctermfg=darkgrey  ctermbg=darkblue
	hi IncSearch	ctermfg=black ctermbg=grey cterm=NONE
	hi Search	ctermfg=black ctermbg=darkgrey cterm=NONE
else
	hi Comment		ctermfg=grey  ctermbg=darkblue
	hi IncSearch	ctermfg=yellow ctermbg=darkyellow cterm=NONE
	hi Search	ctermfg=black ctermbg=darkyellow cterm=NONE
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi Constant	ctermfg=blue
hi Special	ctermfg=darkmagenta
hi Statement	ctermfg=red
hi PreProc	ctermfg=magenta
hi Type		ctermfg=darkblue " ctermbg=darkblue
hi Underlined	ctermfg=yellow cterm=NONE
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1

" new Vim 7.0 items
hi Pmenu        ctermbg=darkblue ctermfg=lightgrey
hi PmenuSel     ctermbg=lightblue ctermfg=white                    

"vim: sw=4


