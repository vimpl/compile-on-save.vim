"" {{{2
" Toggle compile-on-save.
"
" Registers or deregisters an autocmd to call 'make %' on each write of the
" current buffer.
"
" This function is buffer specific and always only applies to the current
" buffer.
"
" @parameter {enable} Whether to enable, disable or toggle the autocmd
"                     0 = disable
"                     1 = enable
"                     2 = toggle
"
function! compile_on_save#toggle(enable) " {{{1
  if a:enable ==# 0 ||
        \ (a:enable ==# 2 && s:is_enabled())
    autocmd! BufWritePost <buffer>
    let b:compile_on_save = 0
    echo "CompileOnSave disabled"
  elseif a:enable ==# 1 ||
        \ (a:enable ==# 2 && !s:is_enabled())
    autocmd BufWritePost <buffer> silent make %
    let b:compile_on_save = 1
    echo "CompileOnSave enabled"
  else
    throw 'Unsupported parameter: enable=' . a:enable
  endif
endfunc " }}}

"" {{{2
" Checks whether the compile_on_save autocmd is currently enabled.
" This is the case when the b:compile_on_save flag is set to 1
"
" @returns 1 if the autocmd is enabled, otherwise 0
function! s:is_enabled() abort " {{{1
  return exists("b:compile_on_save") && b:compile_on_save == 1
endfunction

" vim: set foldmethod=marker :
