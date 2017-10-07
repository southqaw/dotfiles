#!/usr/bin/env bash

cd ~/.vim/bundle
for i in $(ls); do
  cd "$i"
  echo "$i"
  git pull
  cd ..
done
