function! RemoveAllFocusTags()
  let b:winview = winsaveview()
  %s/, :focus//g
  call winrestview(b:winview)
endfunction

:nnoremap <leader>r :call RemoveAllFocusTags()<CR>
