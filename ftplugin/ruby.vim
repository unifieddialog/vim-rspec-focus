function! s:Preserve(command)
  " Save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Do the business
  execute a:command

  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
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
