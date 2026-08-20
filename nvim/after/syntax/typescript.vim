" Neovim's bundled TypeScript syntax (yats) is both more thorough and more
" colourful than the leafgarland plugin this config used to load, so under
" OceanicNext it repaints most of a file. Restore leafgarland's palette.
"
" Built by diffing per-character foreground colours against an nvim with the
" plugin still on the runtimepath: 91.7% of characters match exactly. What is
" left is deliberate --
"   regex literals   leafgarland painted them flat green; flat teal is wanted
"   builtin globals  `Array`, `Math`, `window` were teal; plain here, so that a
"                    builtin reads like any other name in any position
"   `never` `void`   plain in value position (`never(msg)`), where leafgarland
"                    coloured them as types on sight
"   `@deprecated`    orange, where leafgarland made every jsdoc tag teal
"   `.get` `.set`    leafgarland coloured any such property as a keyword; they
"                    are plain here, like every other method call
"   `Promise.all`    leafgarland had `all` on its deprecated list, hence red
"   `1e3`            leafgarland's number pattern missed exponents

" ---------------------------------------------------------------- keywords ---
hi link typescriptVariable StorageClass
hi link typescriptUsing StorageClass
hi link typescriptImport Keyword
hi link typescriptImportType Keyword
hi link typescriptExport Keyword
hi link typescriptExportType Keyword
hi link typescriptModule Keyword
hi link typescriptAmbientDeclaration Keyword
hi link typescriptAbstract Keyword
hi link typescriptEnumKeyword Keyword
hi link typescriptClassStatic Keyword
hi link typescriptMethodAccessor Keyword
hi link typescriptCastKeyword Keyword
hi link typescriptDebugger Keyword
" `readonly` was a Label; `override` leafgarland did not know at all.
syn clear typescriptReadonlyModifier
syn keyword typescriptReadonlyModifier readonly contained
hi link typescriptReadonlyModifier Label
hi link typescriptCase Label
hi link typescriptDefault Label
hi link typescriptIdentifier Identifier
hi link typescriptKeywordOp Operator
hi link typescriptNull Type

" `void` belongs to typescriptOperator even in return-type position, where it
" should be a Type like every other annotation. Dropping it lets
" typescriptPredefinedType claim it there; as an operator it stays plain. The
" rest of the group was grey anyway.
syn clear typescriptOperator
syn keyword typescriptOperator delete new typeof
hi link typescriptOperator Operator

" A handful of words yats files under a neighbour group. Injecting them
" everywhere except inside text is the only way to reach the positions yats' own
" clusters do not.
"
" Keep this list to words that can only ever be keywords. It is position-blind,
" so anything that doubles as an ordinary identifier -- `never(...)` as a call,
" say -- would get painted as a keyword there too.
let s:code = 'ALLBUT,@typescriptComments,typescriptComment,typescriptLineComment,'
      \ . 'typescriptDocComment,typescriptString,typescriptTemplate,'
      \ . 'typescriptStringLiteralType,typescriptTemplateLiteralType,'
      \ . 'typescriptEventString,typescriptRegexpString,typescriptRegexpCharClass,'
      \ . 'typescriptRegexpGroup'

exe 'syn keyword typescriptCustomizedSuper super prototype containedin=' . s:code
exe 'syn keyword typescriptCustomizedThis this arguments containedin=' . s:code
exe 'syn keyword typescriptCustomizedClassKeyword constructor declare containedin=' . s:code

hi link typescriptCustomizedSuper Keyword
hi link typescriptCustomizedThis Identifier
hi link typescriptCustomizedClassKeyword Keyword

" `async` was a Label and `await` a Conditional; yats merges them.
syn clear typescriptAsyncFuncKeyword
syn keyword typescriptAsyncFuncKeyword async skipwhite
      \ nextgroup=typescriptFuncKeyword,typescriptArrowFuncDef,typescriptArrowFuncTypeParameter
syn keyword typescriptCustomizedAwaitOp await skipwhite nextgroup=@typescriptValue,typescriptUsing
syn cluster typescriptTopExpression add=typescriptCustomizedAwaitOp
hi link typescriptAsyncFuncKeyword Label
hi link typescriptCustomizedAwaitOp Conditional

" ...same story for `yield`, which yats files under `return`.
syn clear typescriptStatementKeyword
syn keyword typescriptStatementKeyword with
syn keyword typescriptStatementKeyword return skipwhite contained
      \ nextgroup=@typescriptValue containedin=typescriptBlock
syn keyword typescriptCustomizedYieldOp yield skipwhite
      \ nextgroup=@typescriptValue containedin=typescriptBlock
hi link typescriptStatementKeyword Statement
hi link typescriptCustomizedYieldOp Conditional

" ------------------------------------------------------- names and members ---
" leafgarland left every declared name plain.
hi link typescriptMember NONE
hi link typescriptFuncName NONE
hi link typescriptInterfaceName NONE
hi link typescriptAliasDeclaration NONE
hi link typescriptTypeReference NONE
hi link typescriptTypeParameter NONE
hi link typescriptCall NONE
hi link typescriptFuncCallArg NONE
hi link typescriptArrowFuncArg NONE
hi link typescriptObjectLabel NONE
hi link typescriptFuncType NONE
hi link typescriptAsyncFunc NONE
hi link typescriptAutoAccessor NONE
hi link typescriptAssertType NONE
hi link typescriptUserDefinedType NONE
hi link typescriptTestGlobal NONE
hi link typescriptDestructureVariable NONE
hi link typescriptDestructureLabel NONE
hi link typescriptParamImpl NONE
hi link typescriptOptionalMark NONE
hi link typescriptConstructSignature NONE

" yats colours the whole standard library -- every Array/Date/JSON method, every
" DOM property, every event name. leafgarland knew only the global objects.
for s:g in getcompletion('typescript', 'highlight')
  if s:g =~# '\%(Method\|Prop\|Event\)$'
    exe 'hi link' s:g 'NONE'
  endif
endfor
unlet! s:g
hi link typescriptDOMElemAttrs NONE
hi link typescriptDOMElemFuncs NONE
hi link typescriptDOMNodeType NONE
hi link typescriptDOMStorage NONE
hi link typescriptDOMStyle NONE
hi link typescriptProxyAPI NONE

" ...and the objects themselves go with them. leafgarland painted `Array`, `Math`,
" `window` and the rest teal off a flat word list, which meant a builtin looked
" unlike any other name -- and, since the list was position-blind, unlike itself
" in `Array<string>`, where yats sees only a type reference. Plain everywhere.
hi link typescriptGlobal NONE
hi link typescriptGlobalMethod NONE
hi link typescriptBOM NONE
hi link typescriptBOMWindowCons NONE
hi link typescriptBOMWindowMethod NONE
hi link typescriptBOMWindowProp NONE
hi link typescriptCryptoGlobal NONE
hi link typescriptDOMEventCons NONE
hi link typescriptEncodingGlobal NONE
hi link typescriptNodeGlobal NONE
hi link typescriptXHRGlobal NONE

" ------------------------------------------------- operators and delimiters ---
hi link typescriptTypeBracket Function
hi link typescriptFuncTypeArrow Operator
hi link typescriptArrowFunc Operator
hi link typescriptUnaryOp Boolean
hi link typescriptTemplateSB Delimiter

" `&&` `||` `??` were Boolean, the rest of the binary operators plain.
syn clear typescriptBinaryOp
syn match typescriptBinaryOp contained /===\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained />\(>>=\|>>\|>=\|>\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /<\(<=\|<\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /\*=\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /%=\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained +/\(=\|[^\*/]\@=\)+ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /!==\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /+\(+\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /-\(-\|=\)\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptBinaryOp contained /\*\*=\?/ nextgroup=@typescriptValue
syn match typescriptCustomizedLogicOp contained /||\?=\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptCustomizedLogicOp contained /&&\?=\?/ nextgroup=@typescriptValue skipwhite skipempty
syn match typescriptCustomizedLogicOp contained /??=\?/ nextgroup=@typescriptValue skipwhite skipempty
syn cluster typescriptSymbols add=typescriptCustomizedLogicOp
hi link typescriptBinaryOp Operator
hi link typescriptCustomizedLogicOp Boolean

" leafgarland painted every `;` and `,` red, wherever it sat. yats has the rule
" but only reaches it inside for-headers and type members.
exe 'syn match typescriptCustomizedEndColons /[;,]/ containedin=' . s:code
unlet s:code
hi link typescriptCustomizedEndColons Exception
hi link typescriptEndColons Exception

" --------------------------------------------------------------- jsdoc tags ---
" `@deprecated` carries a warning the other tags do not, so pull it out of the
" flat typescriptDocTags list and paint it orange. Matching `@deprecated` whole
" beats yats' `@`-plus-keyword pair, which both start at the same column.
syn match typescriptCustomizedDocDeprecated /@deprecated\>/ contained
      \ containedin=typescriptDocComment nextgroup=typescriptDocDesc skipwhite
hi link typescriptCustomizedDocDeprecated Constant

" ------------------------------------------------------------ regexp bodies ---
" yats leaves the character-class / group / quantifier pieces unlinked, so most
" of a regex renders as plain text. Paint the whole literal teal instead --
" delimiters, flags and body alike. The region is re-declared only to widen the
" flag set to the current eight; yats' own was missing `d` and `v`.
syn clear typescriptRegexpString
syntax region typescriptRegexpString
      \ start=+\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]+
      \ skip=+\\.\|\[[^]]\{1,}\]+
      \ end=+/[dgimsuvy]\{,8}+
      \ contains=typescriptRegexpCharClass,typescriptRegexpGroup,@typescriptRegexpSpecial
      \ oneline keepend extend

hi link typescriptRegexpString Special
hi link typescriptRegexpBoundary Special
hi link typescriptRegexpBackRef Special
hi link typescriptRegexpQuantifier Special
hi link typescriptRegexpOr Special
hi link typescriptRegexpMod Special
hi link typescriptRegexpGroup Special
hi link typescriptRegexpCharClass Special
