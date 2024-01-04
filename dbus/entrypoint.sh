#!/bin/sh

trap "pkill dbus-daemon" SIGINT
trap "pkill dbus-daemon" SIGTERM

if [ ! -f /etc/dbus-1/session-local.conf ]; then
    tee /etc/dbus-1/session-local.conf <<EOF
<busconfig>
<listen>tcp:bind=${DBUS_LISTEN_ADDRESS},port=${DBUS_LISTEN_PORT}</listen>
<auth>ANONYMOUS</auth>
<allow_anonymous/>
</busconfig>
EOF
fi

exec dbus-daemon --session --nofork --print-address "${@}"
