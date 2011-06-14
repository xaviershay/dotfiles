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
