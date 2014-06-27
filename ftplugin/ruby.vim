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
  let l = line(".")
  let c = col(".")
  execute "silent normal! $"

  if a:0 > 0
    let pattern = a:1
  else
    let pattern = s:focusablesPattern
  endif
  let match = search(pattern, 'bcWn')
  let line = getline(match)

  if s:LineHasFocusTag(line)
    call s:RemoveFocusTag(pattern)
  else
    call s:AddFocusTag(pattern)
  endif
  call cursor(l, c)
endfun

fun! s:AddFocusTag(pattern)
  let match = search(a:pattern, 'bcWn')
  let line = getline(match)
  if s:LineHasFocusTag(line)
  else
    " is this is a single-line assertion w/ no description?
    let singleLineAssertionPattern = 'it { '
    if match(line, singleLineAssertionPattern) >= 0
      let patternToReplace = singleLineAssertionPattern
      let replacement = 'it "", { focus: true } { '
    else
      let patternToReplace = ' do$'
      let replacement = ", focus: true do"
    endif
    let repl = substitute(line, patternToReplace, replacement, "")
    call setline(match, repl)
  endif
endfun

fun! s:RemoveFocusTag(pattern)
  let match = search(a:pattern, 'bcWn')
  let line = getline(match)
  if s:LineHasFocusTag(line)
    " is this is a focused single-line assertion w/ no description?
    let focusedSingleLineAssertionPattern = '"", { focus: true } '
    if match(line, focusedSingleLineAssertionPattern) >= 0
      let patternToReplace = focusedSingleLineAssertionPattern
    else
      let patternToReplace = ', focus: true'
    endif
    let repl = substitute(line, patternToReplace, "", "g")
    call setline(match, repl)
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
