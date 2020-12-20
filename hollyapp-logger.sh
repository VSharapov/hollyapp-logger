#!/bin/bash

#set -x

listID=$1

# First let's make sure we're on the right branch
while [[ "$(git rev-parse --abbrev-ref HEAD)" != "$listID" ]]; do
  echo "The current branch is \"$(git rev-parse --abbrev-ref HEAD)\" and not \"${listID}\""
  git checkout -B "${listID}"
  echo "Tried to checkout \"${listID}\", now on \"$(git rev-parse --abbrev-ref HEAD)\""
  echo "Enter to continue, ^C to quit"
  read
done

