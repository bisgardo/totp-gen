FROM alpine:3
# Install 'coreutils' (for 'base32') 'libqrencode' (for 'qrencode').
RUN apk add --no-cache coreutils libqrencode
COPY /totp-gen.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
