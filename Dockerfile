FROM golang:1.16.3-alpine3.13 AS builder
WORKDIR /src/go

COPY . .

RUN go mod download  && \
    apk add --no-cache git curl gcc libc-dev && \
    go get -d -v github.com/Kong/go-pluginserver && \
    go build github.com/Kong/go-pluginserver
RUN ./build-plugins.sh


FROM kong:2.4-alpine

USER root

RUN mkdir -p /usr/local/go-plugins

COPY --from=builder  /src/go/custom-plugins /usr/local/go-plugins
COPY --from=builder  /src/go/go-pluginserver /usr/local/bin/go-pluginserver

# override kong configuration
COPY ./kong.conf /etc/kong

RUN chmod -R 755 /usr/local/go-plugins/*.so && \
    chmod -R 755 /usr/local/bin/go-pluginserver

USER kong

CMD kong start
