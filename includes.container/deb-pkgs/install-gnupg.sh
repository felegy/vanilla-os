#!/bin/bash
# This script builds and installs GnuPG 2.4.8 in a specified destination directory.
# It also installs necessary dependencies, verifies the GnuPG signature, and cleans up after itself.
# Usage: ./build.sh [DESTDIR]
# Example: ./build.sh /usr/local

set -euo pipefail
GNUPG_VERSION="2.4.8"

TEMPDIR=$(mktemp -d)

(cd "${TEMPDIR}" || exit 1
    trap 'rm -rf "${TEMPDIR}"' EXIT

    apt-get update -qqq
    apt-get upgrade -y
    apt-get install -y libassuan-dev libgcrypt20-dev libgpg-error-dev libksba-dev libnpth0-dev
    apt-get install -y gpg curl build-essential bzip2
    curl -# -LO "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${GNUPG_VERSION}.tar.bz2"
    curl -sL "https://gnupg.org/signature_key.asc" | gpg --import
    curl -sL "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${GNUPG_VERSION}.tar.bz2.sig" | gpg --verify - gnupg-${GNUPG_VERSION}.tar.bz2
    tar xf gnupg-${GNUPG_VERSION}.tar.bz2

    cd gnupg-${GNUPG_VERSION}
    ./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc --docdir="/usr/share/doc/gnupg-${GNUPG_VERSION}" --runstatedir=/run  --enable-all-tests --enable-g13 \
        --enable-symcryptrun --enable-large-secmem --with-capabilities

    if [ $? -ne 0 ]; then
        echo "Configuration failed. Exiting."
        exit 1
    fi

    if [[ -v 1 ]]; then
        mkdir -p "${1}"
        make DESTDIR="${1}" install
    else
        make install
    fi

)
# Clean up temporary directory
rm -rf "${TEMPDIR}"
