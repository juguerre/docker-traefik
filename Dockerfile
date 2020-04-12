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
	/rootfs.tar.gz -L \
	https://github.com/containous/traefik/releases/download/${REL}/traefik_${REL}_linux_${ARCH}.tar.gz && \
 tar xf \
        /rootfs.tar.gz -C \
        /root-out


FROM scratch
COPY --from=rootfs-stage /root-out/ /
COPY script/ca-certificates.crt /etc/ssl/certs/
#COPY dist/traefik /
EXPOSE 80
VOLUME ["/tmp"]
ENTRYPOINT ["/traefik"]