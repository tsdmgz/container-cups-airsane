# D-Bus in a container for containers

This instance of D-Bus is meant for container-to-container use. TCP sockets are
used and authentication is set to `ANONYMOUS`.

**I repeat: this instance is wide open**

Sockets are preferred but I couldn't get it to work for some reason. Maybe some
other time. Protect this instance by binding to localhost only with `--publish
127.0.0.1:8899:8899` if containers in other networks need to talk to it. IPv6
doesn't seem to work or I'm not giving the right options.

# Environment configuration

| Key                   | Default value |
| -                     | -             |
| `DBUS_LISTEN_ADDRESS` | `127.0.0.1`   |
| `DBUS_LISTEN_PORT`    | `8899`        |
