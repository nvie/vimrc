" Treat bare URLs as atomic, otherwise `_` / `__` inside URLs opens
" italic/bold regions that bleed across following lines until a blank line.
syn match markdownBareUrl /\<https\?:\/\/\S\+/ contains=@NoSpell
