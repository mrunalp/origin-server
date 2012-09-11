#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

source "/etc/stickshift/stickshift-node.conf"
source ${CARTRIDGE_BASE_PATH}/abstract/info/lib/util

start_dbs

# Run build

cart_instance_dir=$OPENSHIFT_HOMEDIR/python-2.6

if [ -d $cart_instance_dir/virtenv ]
then 
    pushd $cart_instance_dir/virtenv > /dev/null
    . ./bin/activate
    popd > /dev/null
fi

user_deploy.sh