#!/bin/bash
cd ../../..

commits=$(git rev-list --no-merges $1..$2)
for commit in $commits;
do
  # shellcheck disable=SC2086
  msg=$(git log --format=%B $commit -1)
  echo "$msg" | commitlint
done
