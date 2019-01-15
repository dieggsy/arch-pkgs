#!/bin/sh
export PKGDEST=$(git rev-parse --show-toplevel)

find -name PKGBUILD -execdir makepkg -scf --sign --noconfirm \;

repo-add --sign -n dieggsy.db.tar.xz *.pkg.tar.xz

