#!/usr/bin/env sh

set -eu

length=26 # 26 base32-encoded characters corresponds to 16 bytes.
user=
issuer=
key=

alias log='>&2 echo' # log to stderr

while getopts "hl:u:i:k:" opt; do
	case "${opt}" in
	l)
		length="${OPTARG}"
		;;
	u)
		user="${OPTARG}"
		;;
	i)
		issuer="${OPTARG}"
		;;
	k)
		key="${OPTARG}"
		;;
	*)
		log "Unknown option '${OPTARG}'."
		exit 1
		;;
	esac
done

if [ -z "${user}" ]; then
	log "No user provided (parameter '-u')."
	exit 1
fi
if [ -z "${issuer}" ]; then
	log "No issuer provided (parameter '-i')."
	exit 1
fi

if [ -z "${key}" ]; then
	log "No key provided. Generating new one of length ${length}."
	# Generate key using the exact method that the google-authenticator tool uses to generate the secret token
	# (see 'https://github.com/google/google-authenticator-libpam/blob/0b02aadc28ac261b6c7f5785d2f7f36b3e199d97/src/google-authenticator.c#L774').
	key="$(base32 -w0 < /dev/urandom | head -c "${length}")"
fi

# Display QR code with URI understood by OTP apps
# (docs: 'https://github.com/google/google-authenticator/wiki/Key-Uri-Format').
if command -v qrencode > /dev/null; then
	# TODO Should probably be URI encoded unless 'qrencode' already does this.
	qr="otpauth://totp/${user}@${issuer}?secret=${key}&issuer=${issuer}"
	echo
	# Options '-8' and '-lM' makes the output identical to that of the 'google-authenticator' tool.
	qrencode -t ANSI256 -8 -lM "${qr}"
	echo
else
	log "Not printing QR code because the 'qrencode' tool is not installed."
fi
# Print key.
echo "${key}"
echo
