#! /bin/bash --
# by pts@fazekas.hu at Wed Oct 11 15:24:03 CEST 2017
#

set -ex
cd "${0%/*}"
test -f ../pdfsizeopt.single
if ! test -f pdfsizeopt_libexec_linux.tar.gz; then
  wget -nv -O pdfsizeopt_libexec_linux.tar.gz.tmp https://github.com/pts/pdfsizeopt/releases/download/2023-04-18/pdfsizeopt_libexec_linux-v9.tar.gz
  rm -f pdfsizeopt_libexec_linux.tar.gz
  mv pdfsizeopt_libexec_linux.tar.gz.tmp pdfsizeopt_libexec_linux.tar.gz
fi
if ! test -f busybox; then
  wget -nv -O busybox.tmp https://github.com/pts/pdfsizeopt/releases/download/2017-10-11b/busybox
  chmod 755 busybox.tmp
  rm -f busybox
  mv busybox.tmp busybox
fi
# Doing these chmods early makes the image half as large.
chmod 755 busybox
rm -rf pdfsizeopt_libexec
tar xzvf pdfsizeopt_libexec_linux.tar.gz
chmod 755 pdfsizeopt_libexec/*
rm -f pdfsizeopt.single
cp -a ../pdfsizeopt.single ./
chmod 755 pdfsizeopt.single
# Reads Dockerfile.
docker build -t ptspts/pdfsizeopt .
rm -rf pdfsizeopt_libexec
: docker push ptspts/pdfsizeopt

: build_docker.sh OK.
