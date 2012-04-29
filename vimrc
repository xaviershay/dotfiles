call pathogen#runtime_append_all_bundles()

set nocp          " Disable vi compatibility, for vim-specific awesomeness
set expandtab     " Expand tabs to spaces
set tabstop=2
set bs=2          " Fix backspace key to work under screen
set shiftwidth=2
set number        " Enable line numbering
set autoindent    " When you press enter you stay at the current indent
set wildmode=longest,list " Better tab completion for :e and friends
set wildignore=*.rbc,.git,*.o,*.gem
set history=100   " Default is 20, not enough.

syntax on

filetype plugin indent on

"Disable help key coz I mash it when I try to hit Esc
map <F1> <Esc>
imap <F1> <Esc>

vmap <F2> !format_hash.rb<CR>
vmap <F4> !format_cucumber_table.rb<CR>

set ls=2

vmap o :s/^/# /<CR>
vmap i :s/^# //<CR>
vmap ;h :s/:\(\w*\)\s*=> /\1: /g<CR>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

set gfn=Monofur:h14
set vb

set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim

nmap <tab> :bn<cr>
nmap <s-tab> :bp<cr>

augroup vimrcEx
  "Auto reload this file when editing it
  au! BufWritePost .vimrc source %

  "Add rails filetype to all ruby files, need to find a way to limit to just rails files maybe
  au BufRead,BufNewFile *.rb set filetype=ruby.rails.rspec
  au BufRead,BufNewFile Isolate set filetype=ruby
  au BufRead,BufNewFile config.ru set filetype=ruby

  " Override default modula2 detection, these files are markdown
  au BufNewFile,BufRead *.md set filetype=markdown

  " C style for ruby codes
  au FileType c setl ts=4 sw=4 noexpandtab

  " Exit insert mode when Vim loses focus.
  " A bug prevents this from working: autocmd FocusLost * stopinsert
  " See http://stackoverflow.com/questions/2968548
  autocmd! FocusLost * call feedkeys("\<C-\>\<C-n>")

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

augroup END

set grepprg=ack
set grepformat=%f:%l:%m
let mapleader = ";"
let maplocalleader = ","

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

set winwidth=84

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

" Terminals are plenty fast these days.
set ttyfast

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

if has("mouse")
	set mouse=a
	set mousehide
endif

set colorcolumn=80

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>
