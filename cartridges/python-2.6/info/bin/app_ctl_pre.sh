#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

export APPDIR="${OPENSHIFT_PYTHON_CART_DIR}"