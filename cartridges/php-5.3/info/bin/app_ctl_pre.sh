#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

export PHPRC="${OPENSHIFT_PHP53_CART_DIR}conf/php.ini"
