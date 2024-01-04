FROM docker.io/library/debian:stable-slim AS build
RUN --mount=type=cache,target=/var/cache apt-get update && apt-get -y install libsane-dev libjpeg-dev libpng-dev libavahi-client-dev libusb-1.*-dev git cmake g++
WORKDIR /tmp
RUN git clone https://github.com/SimulPiscator/AirSane.git
WORKDIR ./AirSane-build
RUN cmake ../AirSane
RUN make

FROM docker.io/library/debian:stable-slim
RUN --mount=type=cache,target=/var/cache apt-get update && apt-get -y install --no-install-recommends libsane libjpeg62-turbo libpng16-16 libavahi-client3 libusb-1.* sane-utils
WORKDIR /app
COPY --from=build /tmp/AirSane-build/airsaned airsaned
EXPOSE 8090/tcp
ENV DBUS_SYSTEM_BUS_ADDRESS=tcp:host=printandscan-dbus,port=8899
ENTRYPOINT /app/airsaned ${@}
