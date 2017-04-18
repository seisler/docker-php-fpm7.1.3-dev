#!/usr/bin/env sh

# Extract archive
tar -xf /xdebug-2.5.3.tgz

cd xdebug-2.5.3

# build extension
phpize
./configure
make && make install

rm -rf xdebug-2.5.3 \
    /xdebug-2.5.3 \
    /xdebug-2.5.3.tgz \
    /xdebug.sh
