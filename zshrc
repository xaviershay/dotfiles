TERM=screen
EDITOR="~/bin/mvim --nofork"
PAGER=less

GEM_HOME=/usr/local/Cellar/Gems/1.8
GEM_PATH=/usr/local/Cellar/Gems/1.8:/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/gems/1.8/gems
RUBY_FFI_NCURSES_LIB=libncurses
NODE_PATH=/Users/xavier/Code/node/

PATH=~/bin:$PATH:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin

export HISTSIZE=2000
export HISTFILE="$HOME/.zhistory"
export SAVEHIST=$HISTSIZE

bindkey -e

export TERM EDITOR PAGER GEM_HOME GEM_PATH RUBY_FFI_NCURSES_LIB RUBYOPT NODE_PATH

alias v='~/bin/mvim'
alias gi="sudo gem install"
alias go='cd /Volumes/conversation/tc'

alias gis='git status'
alias gid='git diff --cached'
alias gic='git commit -m'
alias gia='git add'
alias gip='git add -p'
alias grb='git rebase'
alias goc='git checkout'
alias gme='git merge'

alias rmi='LR=1 rake tc:db:prepare tc:dev_data --trace'

alias twitter_ignore="defaults write com.atebits.tweetie-mac filterTerms -array-add"

# Rails
alias rs='rails s'
alias rc='rails console'

export DM_DB_USER=xavier
export DM_DB_PASSWORD=

export XTDO_PATH="~/Dropbox/xtdo.yml"

autoload -U compinit
compinit

_xtdo() {
  # TODO: Complete a bare 'xtdo' with commands + description

  if [[ $words[2] == b ]]; then
    if (( CURRENT == 4 )); then
      compadd `t l c`
    fi
  fi

  if [[ $words[2] == d ]]; then
    if (( CURRENT == 3 )); then
      compadd `t l c`
    fi
  fi

  if [[ $words[2] == r && $words[3] == d ]]; then
    if (( CURRENT == 4 )); then
      compadd `t r c`
    fi
  fi
}

compdef _xtdo t

setopt prompt_subst
setopt hist_ignore_dups

bindkey '^R' history-incremental-search-backward

project_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/~\/Code\/me\/\([^\/]*\)/\\1/"
}

d() {
  cd ~ && dooby $* && cd -
}

export PROMPT=$'%{\e[0;%(?.32.31)m%}ॐ %{\e[0m%} '
export RPROMPT=$'`project_pwd``git_cwd_info`'

unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
