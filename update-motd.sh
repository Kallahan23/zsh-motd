#!/bin/sh

# This script is a copy of the default /etc/profile.d/update-motd.sh found in Ubuntu 20.04.
# The only difference is that it does not check whether it is being called interactively or not.

stamp="$HOME/.motd_shown"

eval_gettext() {
    if type gettext > /dev/null 2>&1 ; then
        echo $(env TEXTDOMAIN=update-motd TEXTDOMAINDIR=/usr/share/locale gettext "$1")
    else
        echo "$1"
    fi
}

# Don't display if .hushlogin exists or MOTD was shown recently
if [ ! -e "$HOME/.hushlogin" ] && [ -z "$MOTD_SHOWN" ] && ! find $stamp -newermt 'today 0:00' 2> /dev/null | grep -q -m 1 '.'; then
    [ $(id -u) -eq 0 ] || SHOW="--show-only"
    update-motd $SHOW
    echo ""
    eval_gettext "This message is shown once once a day. To disable it please create the"
    echo -n "$HOME/.hushlogin "
    eval_gettext "file."
    touch $stamp
    export MOTD_SHOWN=update-motd
fi

unset -f eval_gettext
unset stamp
