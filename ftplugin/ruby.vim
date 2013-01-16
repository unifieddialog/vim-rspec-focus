function! s:Preserve(command)
  " Save cursor position
  let l = line(".")
  let c = col(".")

  " Do the business
  execute a:command

  " Restore cursor position
  call cursor(l, c)
  " Remove search history pollution and restore last search
  call histdel("search", -1)
  let @/ = histget("search", -1)
endfunction

function! s:AddFocusTag()
  call s:Preserve("normal! ? do\<cr>C, :focus do\<esc>")
endfunction

function! s:RemoveAllFocusTags()
  call s:Preserve("%s/, :focus//e")
endfunction

" Commands
command! -nargs=0 AddFocusTag call s:AddFocusTag()
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()

" Mappings
:nnoremap <leader>t :AddFocusTag<CR>
:nnoremap <leader>r :RemoveAllFocusTags<CR>
