#!/usr/bin/env bash
set -eu -o pipefail

error() {
	>&2 echo "$@"
	exit 1
}

if [ $# -lt 2 ]; then
	error "Usage: ${0} CA_CONFIG_FILE MAIN_FQDN [ALTERNATIVE_FQDN...]"
fi

ca_config_file="${1}"
main_fqdn="${2#\*.}" # could contain wildcard at beginning
output_key_file="${main_fqdn}.key"
output_crt_file="${main_fqdn}.crt"
output_csr_file="${main_fqdn}.csr"
if [ -e "${output_key_file}" ] || [ -e "${output_crt_file}" ] || [ -e "${output_csr_file}" ]; then
	error "Output file already exists"
fi

config="$(
	cat "${ca_config_file}"
	echo
	echo "[ alt_names ]"
	for ((i = 2; i <= $#; ++i)); do
		echo "DNS.$((i - 1)) = ${!i}"
	done
)"

openssl genrsa -out "${output_key_file}" 2048

openssl req -new -key "${output_key_file}" -config <(echo "${config}") \
	-subj "/C=DE/ST=Nowhere/L=Nowhere/O=Nowhere/OU=Nowhere/CN=${main_fqdn}" \
	-out "${output_csr_file}"

openssl ca -config <(echo "${config}") -extensions server_cert -in "${output_csr_file}" -out "${output_crt_file}"
