# CUPS and AirSane in containers

A set of containers providing CUPS with AirPrint and AirScan services for
USB-only printers *for home use*.

Instructions assume images have been named as `printandscan-dbus`,
`printandscan-avahi`, `printandscan-cups`, and `printandscan-airsane` on build.

# Running

Start these in order

## Prerequisites

1. Create named volumes called `printandscan-avahi_data`,
   `printandscan-cups_data`, `printandscan-airsane_data`: `echo -n "avahi cups
   airsane"|tr ' ' '\n'|xargs -I{} -n 1 sudo podman volume create
   printandscan-{}_data`
2. Create a network called `printandscan`: `sudo podman network create --ipv6
   printandscan`
3. `echo -n "dbus cups airsane"|tr ' ' '\n'|xargs -I{} -n 1 sudo podman build -t
   printandscan-{} {}`
4. `sudo setsebool container_use_devices=true`

## DBUS

```
sudo podman run -d --rm \
--name printandscan-dbus \
--publish 127.0.0.1:8899:8899 \
--network=printandscan \
printandscan-dbus
```

## Avahi

```
sudo podman run -d --rm \
--name printandscan-avahi \
--network=host \
--volume printandscan-avahi_data:/var/run/avahi-daemon:z \
-e SERVER_ENABLE_DBUS=yes \
-e DBUS_SYSTEM_BUS_ADDRESS=tcp:host=localhost,port=8899 \
--hostname $(hostname -f) \
docker.io/flungo/avahi
```

Avahi should not be running on the host. Host networking is necessary so that
Avahi can send broadcasts properly and get the correct address. I'm not sure how
bad this is for security. Macvlan is an option but haven't figured that part
out yet.

## CUPS

```
sudo podman run -d --rm \
--name printandscan-cups \
--network=printandscan \
--publish 631:631 \
--volumes-from printandscan-avahi \
--volume printandscan-cups_data:/etc/cups/ \
--volume /dev/bus/usb:/dev/bus/usb \
-e DBUS_SYSTEM_BUS_ADDRESS=tcp:host=printandscan-dbus,port=8899 \
--hostname $(hostname -f) \
--uidmap=0:0:1 \
--gidmap=0:0:1 \
--uidmap=4:$(id -u lp):1 \
--gidmap=7:$(id -g lp):1 \
printandscan-cups
```

Only USB printers supported by Gutenprint have been tested so far, specifically
Epson printers.

## AirSane

```
sudo podman run -d --rm \
--name printandscan-airsane \
--network=printandscan \
--publish 8090:8090 \
--publish '[::]:8090:8090' \
--volumes-from printandscan-avahi \
--volume printandscan-airsane_data:/etc/sane.d/ \
--volume /dev/bus/usb:/dev/bus/usb \
--uidmap=0:$(id -u lp) \
--gidmap=0:$(id -g lp) \
--stop-signal SIGKILL \
-e DBUS_SYSTEM_BUS_ADDRESS=tcp:host=printandscan-dbus,port=8899 \
--hostname $(hostname -f) \
printandscan-airsane
```
