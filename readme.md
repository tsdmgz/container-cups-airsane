# CUPS-Airsane in containers

Assume images have been built and named as `printandscan-dbus`,
`printandscan-avahi`, `printandscan-cups`, and `printandscan-airsane`.

# Running

Start these in order

## Prerequisites

1. Create a named volume called `printandscan-avahi-data`
2. Create a named volume called `printandscan-cups-data`
3. Create a network called `printandscan`

## DBUS

`sudo podman run -d --rm --name printandscan-dbus --network=printandscan
localhost/printandscan-dbus`

## Avahi

`sudo podman run -d --rm --name printandscan-avahi --network=host --volume
printandscan-avahi:/var/run/avahi-daemon:z localhost/printandscan-avahi`

Note: it is assumed Avahi is not running on the host. Host networking is
necessary so that Avahi can properly send broadcasts. I'm not sure how bad this
is for security. Macvlan is an option but haven't figured that part out yet.

## CUPS

`sudo podman run -d --rm --privileged --name printandscan-cups
--network=printandscan --publish 631:631 --volume
printandscan-avahi:/var/run/avahi-daemon:z --volume /dev/bus/usb:/dev/bus/usb
localhost/printandscan-cups`

## AirSane

`sudo podman run -d --rm --privileged --name printandscan-airsane
--network=printandscan --publish 8090:8090 --volume
printandscan-avahi:/var/run/avahi-daemon:z --volume /dev/bus/usb:/dev/bus/usb
localhost/printandscan-airsane`
