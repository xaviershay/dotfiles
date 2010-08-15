TERM=screen
EDITOR="~/bin/mvim --nofork"
PAGER=less

GEM_HOME=/usr/local/Cellar/Gems/1.8
GEM_PATH=/usr/local/Cellar/Gems/1.8:/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/gems/1.8/gems
RUBY_FFI_NCURSES_LIB=libncurses

PATH=~/bin:$PATH

bindkey -e

export TERM EDITOR PAGER GEM_HOME GEM_PATH RUBY_FFI_NCURSES_LIB RUBYOPT

alias v='~/bin/mvim'
alias gi="sudo gem install"

alias gis='git status'
alias gid='git diff --cached'
alias gic='git commit -m'
alias gia='git add'

alias rmi='rake db:migrate'

autoload -U compinit
compinit

setopt prompt_subst
setopt hist_ignore_dups

bindkey '^R' history-incremental-search-backward

project_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/~\/Code\/me\/\([^\/]*\)/\\1/"
}

export PROMPT=$'%{\e[0;%(?.32.31)m%}ॐ %{\e[0m%} '
export RPROMPT=$'`project_pwd``git_cwd_info`'

unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
