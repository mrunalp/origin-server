#!/bin/bash -e

cartridge_type="perl-5.10"
source /etc/stickshift/stickshift-node.conf
${CARTRIDGE_BASE_PATH}/abstract-httpd/info/bin/app_ctl.sh "$@"
