rspec-focus.vim
===============

Some helpers for focused RSpec testruns. See this [Railscast](http://railscasts.com/episodes/285-spork) for more information.

## Usage

There are currently four commands:
* AddFocusTag
* RemoveAllFocusTags
* AddPendingTag
* RemoveAllPendingTags

## Installation

Use [pathogen.vim](https://github.com/tpope/vim-pathogen)

### Key bindings
To make it more convenient, add some key bindings to your `.vimrc`:

```vimL
nnoremap <leader>f  :AddFocusTag<CR>          " mark as focused
nnoremap <leader>uf :RemoveAllFocusTags<CR>   " unmark all :focus tag
nnoremap <leader>p  :AddPendingTag<CR>        " mark as pending
nnoremap <leader>up :RemoveAllPendingTags<CR> " unmark pending tags
```
