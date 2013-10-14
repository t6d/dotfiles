#!/usr/bin/env bash

# Load all functions
if [[ -f ~/.bash/functions ]]; then
  source ~/.bash/functions
fi

if [[ -f ~/.bash/env ]]; then
  source ~/.bash/env
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

