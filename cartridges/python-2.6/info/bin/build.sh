#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

if `echo $OPENSHIFT_GEAR_DNS | grep -q .stg.rhcloud.com` || `echo $OPENSHIFT_GEAR_DNS | grep -q .dev.rhcloud.com`
then 
	OPENSHIFT_PYTHON_MIRROR="http://mirror1.stg.rhcloud.com/mirror/python/web/simple"
elif `echo $openshift_gear_dns | grep -q .rhcloud.com`
then
	OPENSHIFT_PYTHON_MIRROR="http://mirror1.prod.rhcloud.com/mirror/python/web/simple"
fi

# Run when jenkins is not being used or run when inside a build
if [ -f "${OPENSHIFT_REPO_DIR}/.openshift/markers/force_clean_build" ]
then
    echo ".openshift/markers/force_clean_build found!  Recreating virtenv" 1>&2
    rm -rf "${OPENSHIFT_PYTHON_CART_DIR}"/virtenv/*
fi

if [ -f ${OPENSHIFT_REPO_DIR}setup.py ]
then
    echo "setup.py found.  Setting up virtualenv"
    cd ~/python-2.6/virtenv

    # Hack to fix symlink on rsync issue
    /bin/rm -f lib64
    virtualenv --system-site-packages ~/python-2.6/virtenv
    . ./bin/activate
	if [ -n "$OPENSHIFT_PYTHON_MIRROR" ]
	then
		python ${OPENSHIFT_REPO_DIR}setup.py develop -i $OPENSHIFT_PYTHON_MIRROR
	else
		python ${OPENSHIFT_REPO_DIR}setup.py develop
	fi
    virtualenv --relocatable ~/python-2.6/virtenv
fi

# Run build
user_build.sh
