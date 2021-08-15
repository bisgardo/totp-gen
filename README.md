# totp-gen

Utility script for generating TOTP key and printing it as a QR code to simplify
importing it into an authenticator app like [Authy](https://authy.com/)
and [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US).

The script is designed to match the corresponding functionality in the
`google-authenticator` tool that ships as part of
[`google-authenticator-libpam`](https://github.com/google/google-authenticator-libpam/).
Being a simple shell script makes it much easier to both understand and change the functionality.

Dependencies of the script:
- A shell capable of running a POSIX-compliant script.
- `base32` (used when generating key).
- `qrencode` for printing QR codes (optional).

## Usage

```
./totp-gen.sh [-k KEY] [-l LENGTH] -u USER -i ISSUER
Options:
-k    Secret key. If omitted, random key of length LENGTH is generated.
-l    Length of generated key (if applicable). Defaults to 26.
-u    Username to display in the authenticator app.
-i    Issuer to display in the authenticator app.
```

## Docker

A dockerfile for building a tiny image (based on `alpine:3`) is provided for convenience:

Build:

```shell
docker build -t totp-gen:latest --pull .
```

Run:

```shell
docker run --rm totp-gen:latest [-k KEY] [-l LENGTH] -u USER -i ISSUER
```

The arguments are as documented in the usage message above.

Note that unless the image has been built locally,
the run command as provided will attempt to download the image from Docker Hub.
This will fail as no such image has been uploaded.
