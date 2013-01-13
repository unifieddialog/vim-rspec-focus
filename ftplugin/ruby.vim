function! s:RemoveAllFocusTags()
  " Save cursor position
  let l = line(".")
  let c = col(".")
  %s/, :focus//e
  call cursor(l, c)
endfunction

" Commands
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()

" Mappings
:nnoremap <leader>r :RemoveAllFocusTags<CR>
