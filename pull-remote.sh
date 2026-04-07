#!/bin/bash
set -e # abort on any error

git fetch upstream
git checkout personal
git rebase upstream/main
git push --force-with-lease origin personal
