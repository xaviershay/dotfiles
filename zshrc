EDITOR=vim
PAGER=less

GEM_HOME=/usr/local/Cellar/Gems/1.8
GEM_PATH=/usr/local/Cellar/Gems/1.8:/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/gems/1.8/gems
RUBY_FFI_NCURSES_LIB=libncurses
NODE_PATH=/Users/xavier/Code/node/

PATH=~/bin:$PATH:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin:~/.cabal/bin
PATH=/usr/local/Cellar/python/2.7.2/bin:$PATH
PATH=/usr/local/Cellar/vim/7.3.266/bin:$PATH

export HISTSIZE=2000
export HISTFILE="$HOME/.zhistory"
export SAVEHIST=$HISTSIZE
export NODE_PATH=/usr/local/lib/node/

export JAVA_OPTS='-d32'
export JRUBY_OPTS=''

bindkey -e

export TERM EDITOR PAGER GEM_HOME GEM_PATH RUBY_FFI_NCURSES_LIB RUBYOPT NODE_PATH

alias tmux="TERM=screen-256color tmux"
# alias v='~/bin/mvim'
alias v='vim'
alias t='~/.cabal/bin/xtdo-hs'
alias fp='filepath'
function gi() {
  gem install $1 --no-rdoc --no-ri
}
alias go='cd /Volumes/conversation/tc'
alias pc='ruby -rpry -r./config/environment -e "Pry.start"'
alias ..='cd ..'
function killpow() {
  ps -A | grep nack_worker | cut -d ' ' -f 1 | xargs kill
}
alias tfld='tail -n 100 -f log/development.log'
alias tflt='tail -n 100 -f log/test.log'
alias pstc='psql tc_development'

alias rke='rake --no-deprecation-warnings'

alias gis='git status'
alias gid='git diff --cached'
alias gic='git commit -m'
alias gia='git add'
alias gip='git add -p'
alias grb='git rebase'
alias goc='git checkout'
alias gme='git merge'
alias grh='git reset HEAD'
alias gp='git push'
alias gpr='git pull --rebase'

alias rmi='bundle exec rake tc:db:prepare tc:data:development --trace'
alias be='bundle exec'

alias twitter_ignore="defaults write com.atebits.tweetie-mac filterTerms -array-add"

# Rails
alias rs='rails s'
alias rc='rails console'

export DM_DB_USER=xavier
export DM_DB_PASSWORD=
export DM_DEV_ROOT=/Users/xavier/Code/ex/dm-dev

export XTDOHS_PATH="/Users/xavier/.xtdo.yml"

autoload -U compinit
compinit

_xtdo() {
  # TODO: Complete a bare 'xtdo' with commands + description

  if [[ $words[2] == b ]]; then
    if (( CURRENT == 4 )); then
      compadd `xtdo-hs l c`
    fi
  fi

  if [[ $words[2] == d ]]; then
    if (( CURRENT == 3 )); then
      compadd `xtdo-hs l c`
    fi
  fi

  if [[ $words[2] == r && $words[3] == d ]]; then
    if (( CURRENT == 4 )); then
      compadd `xtdo-hs r c`
    fi
  fi
}

compdef _xtdo xtdo-hs

setopt prompt_subst
setopt hist_ignore_dups

bindkey '^R' history-incremental-search-backward

project_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/~\/Code\/me\/\([^\/]*\)/\\1/"
}

export PROMPT=$'%{\e[0;%(?.32.31)m%}>%{\e[0m%} '
export RPROMPT=$'`project_pwd``git_cwd_info`'

unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

function title() {
  echo "\033]0;$1\007"
}
