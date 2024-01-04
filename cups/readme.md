# CUPS in a box

CUPS with AirPrint support and Gutenprint drivers.

This is configured to accept all remote connections on startup and **has no
access control whatsoever**. See `cupsd-default.conf` if you need defaults.

This container is set to run as privileged. Do not run in untrusted
environments.

# Environment variables

| Key                       | Default value                         |
| -                         | -                                     |
| `DBUS_SYSTEM_BUS_ADDRESS` | `tcp:host=printandscan-dbus,port=8899 |
