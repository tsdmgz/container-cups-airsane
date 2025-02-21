FROM docker.io/library/alpine:latest
RUN --mount=type=cache,target=/var/cache/apk apk add dbus
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENV DBUS_LISTEN_PORT=8899
ENV DBUS_LISTEN_ADDRESS='0.0.0.0'
ENTRYPOINT /usr/local/bin/entrypoint.sh "${@}"

