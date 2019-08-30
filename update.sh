#!/bin/sh

top_dir="$(git rev-parse --show-toplevel)"
default_dest="$top_dir/pkg"

export PKGDEST=${PKGDEST:-$default_dest}
export SRCDEST="$top_dir/src-common"

mkdir -p $PKGDEST
mkdir -p $SRCDEST

find ! -path "./dieggsy-*" -name PKGBUILD -execdir makepkg -scrf --noconfirm \;

find -path "./dieggsy-*" -name PKGBUILD -execdir makepkg -dcf --noconfirm \;

cd $PKGDEST
repo-add -R dieggsy.db.tar.xz *.pkg.tar.xz

cd -
