# Docker

## Build

`docker build -f Dockerfile.arm -t mattwiater/homedash .`

## Run: Interactive

`docker run -it --rm -p3000:3000 --name homedash mattwiater/homedash /bin/ash`

## Ruby: Version

https://pkgs.alpinelinux.org/packages

tar cvfz homedash.tar.gz homedash/
scp root@homeward.duckdns.org:/addons/homedash.tar.gz homedash.tar.gz

https://developers.home-assistant.io/docs/en/hassio_addon_testing.html

# Build on amd64

`docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" -t local/homedash .`

`docker run -it --rm -v /tmp:/data -p 8888:8888 local/homedash`