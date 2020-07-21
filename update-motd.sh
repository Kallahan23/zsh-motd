#!/bin/sh

# This script is a copy of the default /etc/profile.d/update-motd.sh found in Ubuntu 20.04.
# The only difference is that it does not check whether it is being called interactively or not.
# Also the .hushlogin message has been removed.

stamp="$HOME/.motd_shown"

# Don't display if .hushlogin exists or MOTD was shown recently
if [ ! -e "$HOME/.hushlogin" ] && [ -z "$MOTD_SHOWN" ] && ! find $stamp -newermt 'today 0:00' 2> /dev/null | grep -q -m 1 '.'; then
    [ $(id -u) -eq 0 ] || SHOW="--show-only"
    update-motd $SHOW
    touch $stamp
    export MOTD_SHOWN=update-motd
fi

unset stamp
