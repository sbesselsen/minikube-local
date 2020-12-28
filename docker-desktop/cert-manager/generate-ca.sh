#!/bin/sh
DIR=`dirname $0`
rm -rf $DIR/tmp
mkdir -p $DIR/tmp

DATE=`date +"%Y-%m-%d %H:%M:%S"`

cp /etc/ssl/openssl.cnf $DIR/tmp/openssl-with-ca.cnf
cat $DIR/openssl-ca.cnf >> $DIR/tmp/openssl-with-ca.cnf
openssl genrsa -out $DIR/tmp/ca.key 2048
openssl req -x509 -subj "/CN=Sebastiaan Minikube $DATE" -new -nodes -key $DIR/tmp/ca.key -sha256 -days 3650 -out $DIR/tmp/ca.pem -extensions v3_ca -config $DIR/tmp/openssl-with-ca.cnf
cp $DIR/tmp/ca.pem $DIR/ca.pem
echo "Authorize to trust your new CA..."
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" $DIR/ca.pem
echo "Your CA certificate is in $DIR/ca.pem"
