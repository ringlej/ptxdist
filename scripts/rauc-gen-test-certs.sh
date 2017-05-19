#!/bin/bash
#
# Copyright (C) 2017 by Enrico Joerns <e.joerns@pengutronix.de>
# Copyright (C) 2016 by Jan Luebbe <j.luebbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# ---
#
# Demo script that generates certificate files required to sign and verify
# RAUC update tool bundles.
#

set -xe

ORG="Test Org"
CA="rauc CA"

# After the CRL expires, signatures cannot be verified anymore
CRL="-crldays 5000"

BASE="$(pwd)/rauc-openssl-ca"

if [ -e $BASE ]; then
  echo "$BASE already exists"
  exit 1
fi

mkdir -p $BASE/dev/{private,certs}
touch $BASE/dev/index.txt
echo 01 > $BASE/dev/serial

cat > $BASE/openssl.cnf <<EOF
[ ca ]
default_ca      = CA_default            # The default ca section

[ CA_default ]

dir            = .                     # top dir
database       = \$dir/index.txt        # index file.
new_certs_dir  = \$dir/certs            # new certs dir

certificate    = \$dir/ca.cert.pem       # The CA cert
serial         = \$dir/serial           # serial no file
private_key    = \$dir/private/ca.key.pem# CA private key
RANDFILE       = \$dir/private/.rand    # random number file

default_startdate = 19700101000000Z
default_enddate = 99991231235959Z
default_crl_days= 30                   # how long before next CRL
default_md     = sha256                # md to use

policy         = policy_any            # default policy
email_in_dn    = no                    # Don't add the email into cert DN

name_opt       = ca_default            # Subject name display option
cert_opt       = ca_default            # Certificate display option
copy_extensions = none                 # Don't copy extensions from request

[ policy_any ]
organizationName       = match
commonName             = supplied

[ req ]
default_bits           = 2048
distinguished_name     = req_distinguished_name
x509_extensions        = v3_leaf
encrypt_key = no
default_md = sha256

[ req_distinguished_name ]
commonName                     = Common Name (eg, YOUR name)
commonName_max                 = 64

[ v3_ca ]

subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always,issuer:always
basicConstraints = CA:TRUE

[ v3_inter ]

subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always,issuer:always
basicConstraints = CA:TRUE,pathlen:0

[ v3_leaf ]

subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always,issuer:always
basicConstraints = CA:FALSE
EOF

export OPENSSL_CONF=$BASE/openssl.cnf

echo "Development CA"
cd $BASE/dev
openssl req -newkey rsa -keyout private/ca.key.pem -out ca.csr.pem -subj "/O=$ORG/CN=$ORG $CA Development"
openssl ca -batch -selfsign -extensions v3_ca -in ca.csr.pem -out ca.cert.pem -keyfile private/ca.key.pem

echo "Development Signing Keys 1"
cd $BASE/dev
openssl req -newkey rsa -keyout private/rauc.key.pem -out rauc.csr.pem -subj "/O=$ORG/CN=$ORG Development-1"
openssl ca -batch -extensions v3_leaf -in rauc.csr.pem -out rauc.cert.pem

cat << EOF
===============================================================================

Note that the default application should be to set up a public key
infrastructure at your site and use keys and certificates genereated by these.

In oder to use the just generated files in your BSP for testing purpose or if
you do not intend to use real authentification, follow the instructions below. 

Place the key and certificate file in your platform-dir's config/ folder:

  cp rauc-openssl-ca/private/rauc.key.pem <platform-dir>/config/rauc/rauc.key.pem
  cp rauc-openssl-ca/rauc.cert.pem <platform-dir>/config/rauc/rauc.cert.pem

Place the keyring file in your platform-dir's projectroot/ folder:

  cp rauc-openssl-ca/ca.cert.pem <plaform-dir>/projectroot/etc/rauc/ca.cert.pem

===============================================================================
EOF
