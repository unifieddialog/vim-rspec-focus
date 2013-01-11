function! RemoveAllFocusTags()
  " Sace cursor position
  let l = line(".")
  let c = col(".")
  %s/, :focus//e
  call cursor(l, c)
endfunction

:nnoremap <leader>r :call RemoveAllFocusTags()<CR>
