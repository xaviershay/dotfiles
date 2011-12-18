call pathogen#runtime_append_all_bundles() 

set nocp          " Disable vi compatibility, for vim-specific awesomeness
"set syntax=on     " Enable syntax highlighting
set expandtab     " Expand tabs to spaces
set tabstop=2
set bs=2          " Fix backspace key to work under screen
set shiftwidth=2
set number        " Enable line numbering
set autoindent    " When you press enter you stay at the current indent
set wildmode=longest,list " Better tab completion for :e and friends
set wildignore=*.rbc,.git,*.o,*.gem
set history=100   " Default is 20, not enough.

set hidden " for lustyexplorer
let g:LustyJugglerSuppressRubyWarning = 1

syntax on " I think this is a duplicate of syntax=on above

filetype plugin indent on

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
au BufRead,BufNewFile config.ru set filetype=ruby

" Override default modula2 detection, these files are markdown
au BufNewFile,BufRead *.md set filetype=markdown


"Auto strip trailing whitespace
"autocmd BufWritePre * :%s/\s\+$//e

"source ~/.vim/snippets/support_functions.vim

set grepprg=ack
set grepformat=%f:%l:%m
let mapleader = ";"
let maplocalleader = ","

" :W saves with sudo - seems to be broken tow
" command! W w !sudo tee % > /dev/null

let vimfiles=$HOME . "/.vim"
let sep=":"
let vimclojureRoot = vimfiles."/bundle/vimclojure-2.2.0"
let vimclojure#ParenRainbow = 1
let vimclojure#WantNailgun = 0
let classpath = join( [".", "src", "src/main/clojure", "src/main/resources", "test", "src/test/clojure", "src/test/resources", "classes", "target/classes", "lib/*", "lib/dev/*", "bin", vimfiles."/lib/*" ], sep)

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

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Make tabs and trailing spaces visible when requested
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Use visual bell instead of beeping.
set visualbell

" short info tokens, short command line messages, no intro.
set shortmess=atI

" Disable modelines; not used, risk of security exploits.
set modelines=0

" Default to Unicode/UTF-8 rather than latin1
set encoding=utf-8

" Highlight the screen line of the cursor, easier to find the cursor.
"set cursorline

" Terminals are plenty fast these days.
set ttyfast

" Exit insert mode when Vim loses focus.
" A bug prevents this from working: autocmd FocusLost * stopinsert
" See http://stackoverflow.com/questions/2968548
autocmd! FocusLost * call feedkeys("\<C-\>\<C-n>")

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Arrow keys navigate split windows!
nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>

if has("mouse")
	set mouse=a
	set mousehide
endif

imap <Nul> <Esc>:w<CR>

set colorcolumn=80
