FROM git.phmnl01.dmgznet.com/ci/opensuse/tumbleweed
RUN --mount=type=cache,target=/var/cache zypper --non-interactive in dbus-1-daemon
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENV DBUS_LISTEN_PORT=8899
ENV DBUS_LISTEN_ADDRESS='0.0.0.0'
ENTRYPOINT /usr/local/bin/entrypoint.sh "${@}"

