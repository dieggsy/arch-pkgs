#!/bin/sh
export PKGDEST=$(git rev-parse --show-toplevel)

find -name PKGBUILD -execdir makepkg --sign -scrf --noconfirm \;

repo-add --sign -n dieggsy.db.tar.xz *.pkg.tar.xz

ls -rv *.pkg.tar.xz* | awk -F'[0-9]' '++n[$1]>2' | xargs rm

git clean -ffdx -e '/*.tar.xz*' -e '/*.db*' -e '/*.files*'

