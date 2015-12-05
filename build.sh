#!/bin/bash

package="datahub"
major="0"
minor="6"
patch="0"
release="1"
ver=$major.$minor.$patch-$release
arch="amd64"
control=$package/DEBIAN/control


version=$package"_"$ver"_"$arch

echo building $version.deb
rm -rf $version.deb
sed -i "s/^Version:.*/Version: $ver/g" $control 
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


