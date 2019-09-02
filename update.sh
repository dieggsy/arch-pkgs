#!/bin/sh

[ -z $PASSFILE ] && echo "No passfile" && exit 1;

top_dir="$(git rev-parse --show-toplevel)"
default_dest="$top_dir/pkg"

export PKGDEST=${PKGDEST:-$default_dest}
export SRCDEST="$top_dir/src-common"

mkdir -p $PKGDEST
mkdir -p $SRCDEST

find ! -path "./dieggsy-*" -name PKGBUILD -execdir makepkg -scr --noconfirm \;

find -path "./dieggsy-*" -name PKGBUILD -execdir makepkg -dc --noconfirm \;

cd $PKGDEST
for i in *.pkg.tar.xz; do
    gpg --yes --batch --pinentry=loopback --passhprase-file=$PASSFILE -b $i
done

repo-add -Rn dieggsy.db.tar.xz *.pkg.tar.xz

for ext in db files; do
    gpg --yes --batch --pinentry=loopback --passphrase-file=$PASSFILE -b dieggsy.$ext.tar.xz
    ln -s dieggsy.$ext.tar.xz.sig dieggsy.$ext.sig
done
cd -
