rspec-focus.vim
===============

Some helpers for focused RSpec testruns. See this [Railscast](http://railscasts.com/episodes/285-spork) for more information.

## Usage

Includes the following commands:

* ToggleFocusTag
* AddFocusTag
* RemoveFocusTags
* RemoveAllFocusTags
* ToggleDescribeFocusTag
* ToggleContextFocusTag
* ToggleItFocusTag

## Installation

Use [pathogen.vim](https://github.com/tpope/vim-pathogen) or [Vundle.vim](https://github.com/gmarik/Vundle.vim)

### Key bindings
To make it more convenient, add some key bindings to your `.vimrc`:

    " vim-rspec-focus
    :nnoremap <leader>ff :ToggleFocusTag<CR>
    :nnoremap <leader>fa :AddFocusTag<CR>
    :nnoremap <leader>fr :RemoveFocusTag<CR>
    :nnoremap <leader>fd :ToggleDescribeFocusTag<CR>
    :nnoremap <leader>fc :ToggleContextFocusTag<CR>
    :nnoremap <leader>fi :ToggleItFocusTag<CR>
    :nnoremap <leader>rf :RemoveAllFocusTags<CR>
