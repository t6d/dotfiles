#!/bin/zsh

alias ..="cd .."
alias ...="cd ../.."
alias cd!="cd ..; cd -"

alias g="git"
alias ga="git add"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log"
alias glo="git log --oneline"
alias gp="git push"
alias gpt="git push --set-upstream"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"
alias gs="git status"

# Auto Completion
if type __git_complete >& /dev/null; then
  __git_complete g _git
  __git_complete ga _git_add
  __git_complete gc _git_commit
  __git_complete gco _git_checkout
  __git_complete gd _git_diff
  __git_complete gs _git_status
fi

alias ls="ls --color=auto"
alias ll='ls -hl'
alias la='ls -Ah'
alias lla='ls -Ahl'
