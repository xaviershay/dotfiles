set nocp          " Disable vi compatibility, for vim-specific awesomeness
set syntax=on     " Enable syntax highlighting
set expandtab     " Expand tabs to spaces
set tabstop=2
set shiftwidth=2
set number        " Enable line numbering
set autoindent    " When you press enter you stay at the current indent
set wildmode=longest,list " Better tab completion for :e and friends
colors desert     " totally sexier than white background
syn on " I think this is a duplicate of syntax=on above

vmap <F2> !format_hash.rb<CR>
map <C-S> :w<CR>:rubyf ~/bin/inline-expectations.rb<CR>
imap <C-S> <Esc>:w<CR>:rubyf ~/bin/inline-expectations.rb<CR>
set ls=2
map <C-T> :FuzzyFinderTextMate<CR>

vmap o :s/^/# /<CR>
vmap i :s/^# //<CR>

set guifont=Monaco:h10
set vb
