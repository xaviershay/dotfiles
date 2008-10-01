set nocp
set syntax=on
set expandtab
set tabstop=2
set shiftwidth=2
set number
set autoindent
set wildmode=longest,list
colors desert
syn on

vmap <F2> !format_hash.rb<CR>
map <C-S> :w<CR>:rubyf ~/bin/inline-expectations.rb<CR>
imap <C-S> <Esc>:w<CR>:rubyf ~/bin/inline-expectations.rb<CR>
set ls=2
