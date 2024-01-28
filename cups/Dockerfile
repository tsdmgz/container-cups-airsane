FROM docker.io/library/alpine:latest
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing"|tee -a /etc/apk/repositories 
RUN --mount=type=cache,target=/var/cache apk add cups nss nspr cups-filters gutenprint@testing gutenprint-cups@testing
COPY cupsd-default.conf /etc/cups/cupsd-default.conf
COPY cupsd.conf /etc/cups/cupsd.conf
EXPOSE 631/tcp
ENV DBUS_SYSTEM_BUS_ADDRESS=tcp:host=printandscan-dbus,port=8899
ENTRYPOINT cupsd -f ${@}
