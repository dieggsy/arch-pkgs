#!/bin/sh
PKGDEST=$(git rev-parse --show-toplevel)

find -name PKGBUILD -execdir makepkg -scf \;

repo-add -n dieggsy.db.tar.xz *.pkg.tar.xz

