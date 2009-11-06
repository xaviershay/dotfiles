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

filetype on
filetype plugin on

"Disable help key coz I mash it when I try to hit Esc
map <F1> <Esc>
imap <F1> <Esc>

vmap <F2> !format_hash.rb<CR>
vmap <F4> !format_cucumber_table.rb<CR>
vmap <F5> !format_comment_block.rb<CR>
map <F3> :w<CR>:!osascript -e 'tell application "Safari" to do JavaScript "window.location.reload()" in front document'<CR>
imap <F3> <Esc>:w<CR>:!osascript -e 'tell application "Safari" to do JavaScript "window.location.reload()" in front document'<CR>

set ls=2

vmap o :s/^/# /<CR>
vmap i :s/^# //<CR>

set guifont=Monaco:h12
set vb

set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim

nmap <tab> :bn<cr>
nmap <s-tab> :bp<cr>

"Highlight long lines as an error
autocmd FileType ruby match Error /\%100v.\+/

"Auto reload this file when editing it
au! BufWritePost .vimrc source %

"Add rails filetype to all ruby files, need to find a way to limit to just rails files maybe
au BufRead,BufNewFile *.rb set filetype=ruby.rails.rspec

"Auto strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

source ~/.vim/snippets/support_functions.vim
