#!/bin/bash

echo "Stopping application..."
    for env_var in  $APP_HOME/.env/*_CTL_SCRIPT
    do
        . $env_var
    done
    for cmd in `awk 'BEGIN {
                            for (a in ENVIRON)
                            if (a ~ /DB_CTL_SCRIPT$/)
                            print ENVIRON[a] }'`
    do
        "$cmd stop" || error "Failed to start ${cmd}" 121
    done
    for cmd in `awk 'BEGIN {
                            for (a in ENVIRON)
                                if ((a ~ /_CTL_SCRIPT$/) &&
                                    !(a ~ /DB_CTL_SCRIPT$/) &&
                                    !(a ~ /CART_CTL_SCRIPT$/))
                                        print ENVIRON[a] }'`
    do
        "$cmd stop" || error "Failed to start ${cmd}" 121
    done
    for cmd in `awk 'BEGIN {
                        for (a in ENVIRON)
                            if (a ~ /CART_CTL_SCRIPT$/)
                                print ENVIRON[a] }'`
    do
        "$cmd stop" || error "Failed to start ${cmd}" 121
    done
echo "Done"
