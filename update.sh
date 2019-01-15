#!/bin/sh
export PACKAGER="dieggsy <dieggsy@pm.me>"
export PKGDEST=$(git rev-parse --show-toplevel)

find -name PKGBUILD -execdir makepkg -scf --sign --noconfirm \;

repo-add --sign -n dieggsy.db.tar.xz *.pkg.tar.xz

