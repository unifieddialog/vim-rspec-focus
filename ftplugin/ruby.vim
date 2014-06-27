let s:focusablesPattern = 'describe\|context\|it\|scenario\|feature\|specify'

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
  call s:Preserve("%s/, focus: true")
endfunction

fun! s:RSpecToggleFocus()
  let match = search(s:focusablesPattern, 'bWn')
  :let line = getline(match)

  if match(line, "focus") >= 0
    call s:RSpecRemoveFocus()
  else
    call s:RSpecAddFocus()
  endif
endfun

fun! s:RSpecAddFocus()
  let match = search(s:focusablesPattern, 'bWn')
  :let line = getline(match)
  if match(line, "focus: true") >= 0
  else
    :let repl = substitute(line, ' do$', ", focus: true do", "")
    :call setline(match, repl)
  endif
endfun

fun! s:RSpecRemoveFocus()
  let match = search(s:focusablesPattern, 'bWn')
  :let line = getline(match)
  if match(line, "focus: true") >= 0
    :let repl = substitute(line, ', focus: true', "", "g")
    :call setline(match, repl)
  endif
endfun

" Commands
command! -nargs=0 AddFocusTag call s:AddFocusTag()
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()
command! -nargs=0 RSpecClearFoci :%s/, focus: true//g

command! -nargs=0 RSpecToggleFocus call s:RSpecToggleFocus()
command! -nargs=0 RSpecAddFocus call s:RSpecAddFocus()
command! -nargs=0 RSpecRemoveFocus call s:RSpecRemoveFocus()
