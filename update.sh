#!/bin/sh
export PKGDEST=$(git rev-parse --show-toplevel)

find -name PKGBUILD -execdir makepkg -scf --noconfirm \;

repo-add --sign -n dieggsy.db.tar.xz *.pkg.tar.xz

git clean -ffdx -e '/*.tar.xz*' -e '/*.db*' -e '/*.files*'

