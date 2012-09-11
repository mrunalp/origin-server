#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

cartridge_type="perl-5.10"
cartridge_dir=$OPENSHIFT_HOMEDIR/$cartridge_type

export REPOLIB="${OPENSHIFT_REPO_DIR}libs/"
export LOCALSITELIB="${cartridge_dir}/perl5lib/lib/perl5/"
export PERL5LIB="$REPOLIB:$LOCALSITELIB"