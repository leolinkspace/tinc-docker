#!/bin/sh

VNAME="${VPN_NAME:-roxxorvpn}"

if [ ! -f /.first_run ]; then
        /first_run.sh
fi

exec tincd -n $VNAME -D -d3 -D
