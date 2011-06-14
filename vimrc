set nocp          " Disable vi compatibility, for vim-specific awesomeness
set syntax=on     " Enable syntax highlighting
set expandtab     " Expand tabs to spaces
set tabstop=2
set shiftwidth=2
set number        " Enable line numbering
set autoindent    " When you press enter you stay at the current indent
set wildmode=longest,list " Better tab completion for :e and friends

set hidden " for lustyexplorer
let g:LustyJugglerSuppressRubyWarning = 1

syn on " I think this is a duplicate of syntax=on above

filetype on
filetype plugin on

"Disable help key coz I mash it when I try to hit Esc
map <F1> <Esc>
imap <F1> <Esc>

vmap <F2> !format_hash.rb<CR>
vmap <F4> !format_cucumber_table.rb<CR>
vmap <F5> !format_comment_block.rb<CR>

set ls=2

vmap o :s/^/# /<CR>
vmap i :s/^# //<CR>
vmap ;h :s/:\(\w*\)\s*=> /\1: /g<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

"set guifont=Monaco:h12
set gfn=Monofur:h14
"set gfn=Inconsolata:h20
set vb

set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim

nmap <tab> :bn<cr>
nmap <s-tab> :bp<cr>

"Highlight long lines as an error
"autocmd FileType ruby match Error /\%100v.\+/

"Auto reload this file when editing it
au! BufWritePost .vimrc source %

"Add rails filetype to all ruby files, need to find a way to limit to just rails files maybe
au BufRead,BufNewFile *.rb set filetype=ruby.rails.rspec
au BufRead,BufNewFile Isolate set filetype=ruby

" Override default modula2 detection, these files are markdown
au BufNewFile,BufRead *.md set filetype=markdown

"Auto strip trailing whitespace
"autocmd BufWritePre * :%s/\s\+$//e

"source ~/.vim/snippets/support_functions.vim

set grepprg=ack
set grepformat=%f:%l:%m
let mapleader = ";"

" :W saves with sudo - seems to be broken tow
" command! W w !sudo tee % > /dev/null

call pathogen#runtime_append_all_bundles() 

" Not sure why vim-coffee-script doesn't apply this for me
autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" For rubyblock text objects
runtime macros/matchit.vim


if has("gui_running")
  set guioptions=egmrt
endif

set t_Co=256

set background=dark
colorscheme solarized

function! ToggleBackground()
  if (g:solarized_style=="dark")
    let g:solarized_style="light"
    colorscheme solarized
  else
    let g:solarized_style="dark"
    colorscheme solarized
  endif
endfunction

command! Togbg call ToggleBackground()
nnoremap <F3> :call ToggleBackground()<CR>
inoremap <F3> <ESC>:call ToggleBackground()<CR>a
vnoremap <F3> <ESC>:call ToggleBackground()<CR>

map <Leader>e <Leader>lf
map <Leader>b <Leader>lb

" C style for ruby codes
au FileType c setl ts=4 sw=4 noexpandtab

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

nnoremap <leader><leader> <c-^>

" Rails specific
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
