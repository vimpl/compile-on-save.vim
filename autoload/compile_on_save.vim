""
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
function! compile_on_save#toggle(enable)
  if a:enable ==# 0 ||
        \ (a:enable ==# 2 && s:is_enabled())
    autocmd! BufWritePost <buffer>
    let b:compile_on_save = 0
    echo "CompileOnSave disabled"
  elseif a:enable ==# 1 ||
        \ (a:enable ==# 2 && !s:is_enabled())
    autocmd BufWritePost <buffer> silent call s:make()
    let b:compile_on_save = 1
    echo "CompileOnSave enabled"
  else
    throw 'Unsupported parameter: enable=' . a:enable
  endif
endfunc

""
" Checks whether the compile_on_save autocmd is currently enabled.
" This is the case when the b:compile_on_save flag is set to 1
"
" @returns 1 if the autocmd is enabled, otherwise 0
function! s:is_enabled() abort
  return exists("b:compile_on_save") && b:compile_on_save == 1
endfunction

""
" Execute the actual make command.
" This checks for the existence of vim-dispatchs :Make command and uses
" that to call :make in the background. Otherwise is just calls the builtin
" :make.
function! s:make() abort
  if exists(':Make') == 2
    execute ':Make! %'
  else
    execute ':make %'
  endif
endfunction

" vim: set foldmethod=marker :
