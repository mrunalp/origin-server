#!/bin/bash

source "/etc/stickshift/stickshift-node.conf"
source ${CARTRIDGE_BASE_PATH}/abstract/info/lib/util

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

CART_CONF_DIR=${CARTRIDGE_BASE_PATH}/${CARTRIDGE_TYPE}/info/configuration/etc/conf

# Stop the app
src_user_hook pre_stop_${CARTRIDGE_TYPE}
set_app_state stopped
httpd_pid=`cat ${OPENSHIFT_HOMEDIR}/${CARTRIDGE_TYPE}/run/httpd.pid 2> /dev/null`
/usr/sbin/httpd -C "Include ${OPENSHIFT_HOMEDIR}/${CARTRIDGE_TYPE}/conf.d/*.conf" -f $CART_CONF_DIR/httpd_nolog.conf -k $1
wait_for_stop $httpd_pid
run_user_hook post_stop_${CARTRIDGE_TYPE}
