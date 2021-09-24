## Oathtool in Docker

A dockerfile for building a tiny image (based on `alpine:3`) is provided for convenience:

Build:

```shell
docker build -t totp-token:latest --pull .
```

Run:

```shell
docker run --rm totp-token:latest <secret-key>
```
