FROM alpine:3
RUN apk add --no-cache oath-toolkit-oathtool
ENTRYPOINT ["/usr/bin/oathtool", "-b", "--totp"]
