#!/usr/bin/env zsh
update_file=~/.dotfiles-update
epoch_target=15

zmodload zsh/datetime

function _current_epoch() {
  echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_file() {
  echo "LAST_EPOCH=$(_current_epoch)" >! $update_file
}

function _upgrade() {
  cd ~/dotfiles
  git pull
  cd ~/dotfiles.local
  git pull
  _update_file
}

[ -f ~/.profile ] && source ~/.profile

if [ -f $update_file ]; then
  . $update_file
  [[ -z "$LAST_EPOCH" ]] && _update_file && return 0
  epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
  [ $epoch_diff -gt $epoch_target ] && _upgrade
else
  # create the zsh file
  _update_file
fi
