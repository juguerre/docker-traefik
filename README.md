# juguerre/docker-traefik

This is a convenient Docker image for i386 architecture that is not supported for the oficial docker hub repo [traefik repo](https://hub.docker.com/_/traefik).

Any way official [traefik github repo](https://github.com/containous/traefik) has specific i386 releases so is fine to build an image around.

For example:

```shell
docker build . --file Dockerfile --build-arg VERSION=0.1 --build-arg BUILD_DATE=12/04/2020 -t i386-traefik:1.7.23
```

> You can use the image directly from [juguerre/i386-traefik](https://hub.docker.com/r/juguerre/i386-traefik)
```
docker pull juguerre/i386-traefik
```
