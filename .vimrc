set nocompatible

nnoremap <SPACE> <Nop>
let mapleader=" "

" case insensitive search unless capital letter is used
set ignorecase
set smartcase

set number relativenumber 

" center automatically when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" ideavim stuff
if has('ide')
  " mappings and options that exist only in IdeaVim
  map <leader>f <Action>(GotoFile)
  map <leader>g <Action>(FindInPath)
  map <leader>b <Action>(Switcher)

  if &ide =~? 'intellij idea'
    if &ide =~? 'community'
      " some mappings and options for IntelliJ IDEA Community Edition
    elseif &ide =~? 'ultimate'
      " some mappings and options for IntelliJ IDEA Ultimate Edition
    endif
  elseif &ide =~? 'pycharm'
    " PyCharm specific mappings and options
  endif
else
  " some mappings for Vim/Neovim
  " nnoremap <leader>f <cmd>Telescope find_files<cr>
endif
