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
  dot
  git pull --rebase --stat origin master
  dotl
  git pull --rebase --stat origin master
  _update_file
}

[ -f ~/.profile ] && source ~/.profile

if [ -f $update_file ]; then
  . $update_file

  if [[ -z "$LAST_EPOCH" ]]; then
    _update_file && return 0;
  fi

  epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
  if [ $epoch_diff -gt $epoch_target ]; then
    dload zsh/datetime
    _upgrade
  fi
else
  # create the zsh file
  _update_file
fi

