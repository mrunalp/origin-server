#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

source /etc/stickshift/stickshift-node.conf
source ${CARTRIDGE_BASE_PATH}/abstract/info/lib/util

${CARTRIDGE_BASE_PATH}/abstract/info/bin/deploy.sh

framework_carts=($(get_installed_framework_carts))
primary_framework_cart=${framework_carts[0]}

# Sync to the other gears
${CARTRIDGE_BASE_PATH}/${primary_framework_cart}/info/bin/sync_gears.sh

#user_deploy.sh
