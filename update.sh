#!/bin/sh

default_dest="$(git rev-parse --show-toplevel)/pkg"
[ $PKGDEST ] || mkdir -p default_dest

export PKGDEST=${PKGDEST:-$default_dest}

find ! -path "./dieggsy-*" -name PKGBUILD -execdir makepkg --sign -scrf --noconfirm \;

find -path "./dieggsy-*" -name PKGBUILD -execdir makepkg --sign -dcf --noconfirm \;

repo-add --sign -n dieggsy.db.tar.xz *.pkg.tar.xz

ls -rv *.pkg.tar.xz* | awk -F'[0-9]' '++n[$1]>2' | xargs -r rm

git clean -ffdx -e '/*.tar.xz*' -e '/*.db*' -e '/*.files*'

