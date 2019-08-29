#!/bin/sh

top_dir="$(git rev-parse --show-toplevel)"
default_dest="$top_dir/pkg"

export PKGDEST=${PKGDEST:-$default_dest}
export SRCDEST="$top_dir/src-common"

mkdir -p $PKGDEST
mkdir -p $SRCDEST

find ! -path "./dieggsy-*" -name PKGBUILD -execdir makepkg --sign -scrf --noconfirm \;

find -path "./dieggsy-*" -name PKGBUILD -execdir makepkg --sign -dcf --noconfirm \;

cd $PKGDEST
repo-add --sign dieggsy.db.tar.xz *.pkg.tar.xz

ls -rv *.pkg.tar.xz* | awk -F'[0-9]' '++n[$1]>2' | xargs -r rm
cd -
