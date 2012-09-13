#!/bin/bash -e

export cartridge_type="postgresql-8.4"

source /etc/stickshift/stickshift-node.conf
source ${CARTRIDGE_BASE_PATH}/abstract/info/lib/util

# Import Environment Variables
for f in ~/.env/*; do
    . $f
done

translate_env_vars

if ! [ $# -eq 1 ]; then
    echo "Usage: \$0 [start|restart|reload|graceful|graceful-stop|stop|status]"
    exit 1
fi

validate_run_as_user

postgresql_ctl="$CARTRIDGE_BASE_PATH/$cartridge_type/info/bin/postgresql_ctl.sh"

case "$1" in
    start)                    "$postgresql_ctl" start    ;;
    restart|reload|graceful)  "$postgresql_ctl" restart  ;;
    stop|graceful-stop)       "$postgresql_ctl" stop     ;;
    status)                   "$postgresql_ctl" status   ;;
esac
