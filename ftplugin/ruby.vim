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
  call s:Preserve("normal! ?\\(describe\\|it\\|context\\|scenario\\|feature\\|specify\\)\\s\\+['\"].*['\"]\\s\\+do\<cr>$bhi, :focus\<esc>")
endfunction

function! s:AddPendingTag()
  call s:Preserve("normal! ?\\(describe\\|it\\|context\\|scenario\\|feature\\|specify\\)\\s\\+['\"].*['\"]\\s\\+do\<cr>$bhi, :pending\<esc>")
endfunction

function! s:RemoveAllFocusTags()
  call s:Preserve("%s/, :focus//e")
endfunction

function! s:RemoveAllPendingTags()
  call s:Preserve("%s/, :pending//e")
endfunction

" Commands
command! -nargs=0 AddFocusTag call s:AddFocusTag()
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()
command! -nargs=0 AddPendingTag call s:AddPendingTag()
command! -nargs=0 RemoveAllPendingTags call s:RemoveAllPendingTags()
