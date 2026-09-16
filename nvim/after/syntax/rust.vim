" Rust's bundled syntax links doc comments (`///`, `//!`, `/** */`) to
" SpecialComment, which OceanicNext paints teal. A doc comment is still a
" comment, and on a well-documented file the teal outshouts the code it
" documents. Paint them like every other comment.
"
" The other doc-comment groups (block docs, the `///` leader, code fences)
" all link to rustCommentLineDoc, so they follow along.
hi link rustCommentLineDoc Comment

" Rust's bundled syntax re-includes itself inside ```-fenced code blocks in doc
" comments, so example code reads as live code rather than as documentation.
" Drop the embedded regions; the surrounding doc comment then covers them.
syntax clear rustCommentLinesDocRustCode
syntax clear rustCommentBlockDocRustCode
