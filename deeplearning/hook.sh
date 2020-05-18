#!/usr/bin/env bash

sudo mkdir /home/private

if [ -n "$SSH_CONFIG" ]; then
  echo "copying ssh config from \"$SSH_CONFIG\""
  cp -r $SSH_CONFIG /home/private/.ssh
fi

sudo chown -R $NB_USER /home/private

# (re-)start ssh daemon
service ssh restart
