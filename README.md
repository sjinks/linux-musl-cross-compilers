# linux-musl-cross-compilers

[![Build](https://github.com/sjinks/linux-musl-cross-compilers/actions/workflows/build.yml/badge.svg)](https://github.com/sjinks/linux-musl-cross-compilers/actions/workflows/build.yml)

A Docker image with musl-based toolchains for cross-compilation.

## Usage

```Dockerfile
# syntax = docker/dockerfile:1.2
FROM --platform=amd64 wildwildangel/linux-musl-cross-compilers AS build-base
RUN apk add --no-cache your-dependencies

FROM build-base AS build
ARG TARGETPLATFORM
WORKDIR /src
COPY . .
RUN \
    $(setvars ${TARGETPLATFORM}) && \
    # your build commands go here
```
