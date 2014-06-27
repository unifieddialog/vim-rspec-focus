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

fun! s:LineHasFocusTag(line)
  return match(a:line, "focus: true") >= 0
endfun

fun! s:ToggleFocusTag(...)
  if a:0 > 0
    let pattern = a:1
  else
    let pattern = s:focusablesPattern
  endif
  let match = search(pattern, 'bWn')
  :let line = getline(match)

  if s:LineHasFocusTag(line)
    call s:RemoveFocusTag(pattern)
  else
    call s:AddFocusTag(pattern)
  endif
endfun

fun! s:AddFocusTag(pattern)
  let match = search(a:pattern, 'bWn')
  :let line = getline(match)
  if s:LineHasFocusTag(line)
  else
    if match(line, "it { ") >= 0
      :let repl = substitute(line, 'it { ', 'it "", { focus: true } { ', "")
    else
      :let repl = substitute(line, ' do$', ", focus: true do", "")
    endif
    :call setline(match, repl)
  endif
endfun

fun! s:RemoveFocusTag(pattern)
  let match = search(a:pattern, 'bWn')
  :let line = getline(match)
  if s:LineHasFocusTag(line)
    if match(line, '"", { focus: true } ') >= 0
      :let repl = substitute(line, '"", { focus: true } ', "", "g")
    else
      :let repl = substitute(line, ', focus: true', "", "g")
    endif
    :call setline(match, repl)
  endif
endfun

function! s:RemoveAllFocusTags()
  call s:Preserve("%s/, focus: true//e")
endfunction

" Commands
command! -nargs=0 ToggleFocusTag call s:ToggleFocusTag()
command! -nargs=0 AddFocusTag call s:AddFocusTag(s:focusablesPattern)
command! -nargs=0 RemoveFocusTag call s:RemoveFocusTag(s:focusablesPattern)
command! -nargs=0 RemoveAllFocusTags call s:RemoveAllFocusTags()

command! -nargs=0 ToggleDescribeFocusTag call s:ToggleFocusTag("describe")
command! -nargs=0 ToggleContextFocusTag call s:ToggleFocusTag("context")
command! -nargs=0 ToggleItFocusTag call s:ToggleFocusTag("it")
