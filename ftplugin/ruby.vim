function! RemoveAllFocusTags()
  %s/, :focus//g
endfunction

:nnoremap <leader>r :call RemoveAllFocusTags()<CR>
