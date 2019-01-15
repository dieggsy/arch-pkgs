#!/bin/sh
export PKGDEST=$(git rev-parse --show-toplevel)

find -mindepth 2 -name .git -execdir git pull origin master \;

find -name PKGBUILD -execdir makepkg -sf --sign --noconfirm \;

repo-add --sign -n dieggsy.db.tar.xz *.pkg.tar.xz

