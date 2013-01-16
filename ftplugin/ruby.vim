function! s:AddFocusTag()
  " Save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")

  execute "normal! ? do\<cr>C, :focus do\<esc>"
  "
  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! s:RemoveAllFocusTags()
  " Save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")

  %s/, :focus//e

  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Commands
command! -nargs=0 AddFocusTag call s:AddFocusTag()
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()

" Mappings
:nnoremap <leader>t :AddFocusTag<CR>
:nnoremap <leader>r :RemoveAllFocusTags<CR>
