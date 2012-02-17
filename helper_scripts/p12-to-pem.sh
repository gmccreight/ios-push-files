#!/bin/bash

export infile_p12=$1
export outfile_pem=$2

if [ "$outfile_pem" == '' ]
then
    echo usage: $0 infile.p12 outfile.pem
    exit -1
fi

openssl pkcs12 -in $infile_p12 -out $outfile_pem -nodes
