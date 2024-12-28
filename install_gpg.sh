curl -sLO --output-dir /tmp https://github.com/felegy/vanilla-os/raw/refs/heads/main/gnupg-2.4.6.tgz
cd /
tar zxfv /tmp/gnupg-2.4.6.tgz
mkdir -p /usr/local/lib/pkgconfig/
chmod o+rx /usr/local/lib/pkgconfig/
chmod o+rx /usr/local/libexec/
