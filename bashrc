#!/usr/bin/env bash

# Load all functions
if [[ -f ~/.bash/functions ]]; then
  source ~/.bash/functions
fi

# Set up the environment – this needs to be executed only once since the
# environment is inherited
export DOTFILES_SHOULD_LOAD_ENV=${DOTFILES_SHOULD_LOAD_ENV-true}
if $($DOTFILES_SHOULD_LOAD_ENV); then
  source ~/.bash/env
  DOTFILES_SHOULD_LOAD_ENV=false
fi

# Load aliases
if [[ -f ~/.bash/aliases ]]; then
  source ~/.bash/aliases
fi

# Configure the prompt – only if the sell is interactive
if [[ shell_is_interactive && -f ~/.bash/config ]]; then
  source ~/.bash/config
fi

# Load system specific settings if present
if [[ -f ~/.localrc ]]; then
  source ~/.localrc
fi

