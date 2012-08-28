#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

export REPOLIB="${OPENSHIFT_REPO_DIR}libs/"
export LOCALSITELIB="${OPENSHIFT_PERL_CART_DIR}perl5lib/lib/perl5/"
export PERL5LIB="$REPOLIB:$LOCALSITELIB"