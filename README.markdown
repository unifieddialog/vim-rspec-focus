rspec-focus.vim
===============

Some helpers for focused RSpec testruns. See this [Railscast](http://railscasts.com/episodes/285-spork) for more information.

## Usage

There are currently two commands:
* AddFocusTag
* RemoveAllFocusTags

## Installation

Use [pathogen.vim](https://github.com/tpope/vim-pathogen)

### Key bindings
To make it more convenient, add some key bindings to your `.vimrc`:

    " vim-rspec-focus
    :nnoremap <leader>t :AddFocusTag<CR>
    :nnoremap <leader>r :RemoveAllFocusTags<CR>
