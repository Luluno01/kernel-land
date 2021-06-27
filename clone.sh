#!/bin/bash

if [[ ! -d linux.git ]]; then
  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux.git --mirror
fi

if [ -z "$1" ]; then
  echo Usage:
  echo "  ./clone.sh <tag-version>"
  exit 1
fi

git clone -b $1 file://`pwd`/linux.git $1 --depth=1
