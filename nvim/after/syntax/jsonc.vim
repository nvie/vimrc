" JSONC allows trailing commas and comments, but the elzr/vim-json syntax
" (loaded by the built-in jsonc.vim via `runtime! syntax/json.vim`) flags
" them as errors. Clear those error groups for jsonc buffers.
syn clear jsonTrailingCommaError
syn clear jsonCommentError
syn clear jsonMissingCommaError
