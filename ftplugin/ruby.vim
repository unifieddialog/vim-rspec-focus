function! s:AddFocusTag()
  execute "normal! ? do\<cr>C, :focus do\<esc>"
endfunction

function! s:RemoveAllFocusTags()
  " Save cursor position
  let l = line(".")
  let c = col(".")
  %s/, :focus//e
  call cursor(l, c)
endfunction

" Commands
command! -nargs=0 AddFocusTag call s:AddFocusTag()
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()

" Mappings
:nnoremap <leader>t :AddFocusTag<CR>
:nnoremap <leader>r :RemoveAllFocusTags<CR>
