#!/bin/bash

package="datahub"
major="0"
minor="5"
patch="1"
release="1"
arch="amd64"
control=$package/DEBIAN/control


version=$package"_"$major.$minor.$patch-$release"_"$arch

echo building $version.deb
rm -rf $version.deb
echo -e "press \x1b[1mENTER\x1b[0m to edit control file."

read dummy

vi $control

cat $control

cp ../datahub/datahub $package/usr/bin
strip $package/usr/bin/datahub

cd $package
md5sum usr/bin/datahub  > DEBIAN/md5sums 
cd ..

fakeroot dpkg-deb --build $package $version.deb
lintian $version.deb


