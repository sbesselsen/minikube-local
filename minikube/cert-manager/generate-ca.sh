#!/bin/sh
cp /etc/ssl/openssl.cnf data/openssl-with-ca.cnf
cat openssl-ca.cnf >> data/openssl-with-ca.cnf
openssl genrsa -out data/ca.key 2048
openssl req -x509 -new -nodes -key data/ca.key -sha256 -days 3650 -out data/ca.pem -extensions v3_ca -config data/openssl-with-ca.cnf
open data/ca.pem
