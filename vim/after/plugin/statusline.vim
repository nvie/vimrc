" put fugitive info in statusline if available
if exists('g:loaded_fugitive')
   set statusline=%f\ %m\ %r\ %=%{fugitive#statusline()}\ ln:%-03l/%-03L\ col:%-03c\ buf:%n\ 
else
   set statusline=%f\ %m\ %r\ %=\ ln:%-03l/%-03L\ col:%-03c\ buf:%n\ 
endif
