#!/bin/sh
DIR=`dirname $0`
rm -rf $DIR/tmp
mkdir -p $DIR/tmp

cp /etc/ssl/openssl.cnf $DIR/tmp/openssl-with-ca.cnf
cat $DIR/openssl-ca.cnf >> $DIR/tmp/openssl-with-ca.cnf
openssl genrsa -out $DIR/tmp/ca.key 2048
openssl req -x509 -new -nodes -key $DIR/tmp/ca.key -sha256 -days 3650 -out $DIR/tmp/ca.pem -extensions v3_ca -config $DIR/tmp/openssl-with-ca.cnf
open $DIR/tmp/ca.pem
