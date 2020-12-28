#!/bin/bash

#set -x

git branch | grep "^..holly-*" | cut -c9- > target.list

for listID in $(cat target.list | tr '\n' ' '); do 
  listBranch="holly-${listID}"
  # First let's make sure we're on the right branch
  while [[ "$(git rev-parse --abbrev-ref HEAD)" != "$listBranch" ]]; do
    #DEBUG# echo "The current branch is \"$(git rev-parse --abbrev-ref HEAD)\" and not \"${listBranch}\""
    git checkout -B "${listBranch}"
    #DEBUG# echo "Tried to checkout \"${listBranch}\", now on \"$(git rev-parse --abbrev-ref HEAD)\""
    #DEBUG# echo "Enter to continue, ^C to quit"
    #DEBUG# read
  done

  linesBefore="$(cat ${listID}.todo | wc -l)"
  ./holly-curl.sh $listID
  linesAfter="$(cat ${listID}.todo | wc -l)"
  timeStamp="$(cat ${listID}.time)"
  rm ${listID}.time
  git add ${listID}.todo
  commitMessage="${linesBefore} -> ${linesAfter}"
  GIT_AUTHOR_DATE="$timeStamp"
  GIT_COMMITTER_DATE="$timeStamp"
  git commit --date="$timeStamp" -m "${commitMessage}"
done
rm target.list
git checkout main

