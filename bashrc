#!/usr/bin/env bash

export DOTFILES_SHOULD_LOAD_ENV=${DOTFILES_SHOULD_LOAD_ENV-true}
if $($DOTFILES_SHOULD_LOAD_ENV); then
  source ~/.bash/env
  DOTFILES_SHOULD_LOAD_ENV=false
fi

[[ -f ~/.bash/functions ]]  && source ~/.bash/functions
[[ -f ~/.bash/aliases ]]    && source ~/.bash/aliases
[[ -f ~/.bash/config ]]     && source ~/.bash/config

[[ -f ~/.localrc ]] && source ~/.localrc
