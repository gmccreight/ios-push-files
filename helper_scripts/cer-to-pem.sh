#!/bin/bash

export infile_cer=$1
export outfile_pem=$2

if [ "$outfile_pem" == '' ]
then
    echo usage: $0 infile.cer outfile.pem
    exit -1
fi

openssl x509 -in $infile_cer -inform der -out $outfile_pem
