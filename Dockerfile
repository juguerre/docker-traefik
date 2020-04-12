FROM alpine:3.10 as rootfs-stage

# environment
ENV REL=v2.2.0
ENV ARCH=386
ENV MIRROR=http://dl-cdn.alpinelinux.org/alpine
ENV PACKAGES=alpine-baselayout,\
alpine-keys,\
apk-tools,\
busybox,\
libc-utils,\
xz

# install packages
RUN \
 apk add --no-cache \
	bash \
	curl \
	tzdata \
	xz
# grab base tarball
RUN \
 mkdir /root-out && \
 curl -o \
	/traefik -L \
	https://github.com/containous/traefik/releases/download/v1.7.23/traefik_linux-386 && \
 cp \
        /traefik \
        /root-out && \
 chmod +x /root-out/traefik


FROM scratch
COPY --from=rootfs-stage /root-out/ /
COPY script/ca-certificates.crt /etc/ssl/certs/
#COPY dist/traefik /
EXPOSE 80
VOLUME ["/tmp"]
ENTRYPOINT ["/traefik"]

