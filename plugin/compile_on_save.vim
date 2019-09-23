" Vim plugin to enable a compile-on-save trigger                {{{
" Maintainer:   Marco Herrn <marco@mherrn.de>
" Last Changed: 19. September 2019
" URL:          http://github.com/hupfdule/compile-on-save.vim/
" Version:      1.1.0
" License:      MIT

if exists("g:loaded_compile_on_save")
  finish
endif
let g:loaded_compile_on_save = 1

let s:save_cpo = &cpo
set cpo&vim

" End boilerplate }}}

" Commands ============================================================= {{{

  ""
  " Enable the compile-on-save trigger for the current buffer.
  " When the bang [!] is appended it disables the trigger instead.
  command -bang CompileOnSave        :call compile_on_save#toggle(!<bang>0)

  ""
  " Toggle the compile-on-save trigger for the current buffer.
  command       CompileOnSaveToggle  :call compile_on_save#toggle(2)

" END Commands }}}

" Mappings ============================================================= {{{

  ""
  " Enable the compile-on-save trigger for the current buffer
  noremap <Plug>(CompileOnSave)  :CompileOnSave<CR>
  "
  ""
  " Disable the compile-on-save trigger for the current buffer
  noremap <Plug>(CompileOnSave!) :CompileOnSave!<CR>

  ""
  " Toggle the compile-on-save trigger for the current buffer
  noremap <Plug>(CompileOnSaveToggle)  :CompileOnSaveToggle<CR>

" END Mappings }}}

" vim: set foldmethod=marker :
