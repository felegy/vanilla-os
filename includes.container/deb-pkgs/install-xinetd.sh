#!/bin/bash
set -e
tee /etc/xinetd.d/vscode-http <<EOF
service vscode-http
{
    type            = UNLISTED
    port            = 80
    bind            = 127.0.0.1
    protocol        = tcp
    socket_type     = stream
    wait            = no
    user            = nobody
    redirect        = 127.0.0.1 6780
}
EOF

tee /etc/xinetd.d/vscode-https <<EOF
service vscode-https
{
    type            = UNLISTED
    port            = 443
    bind            = 127.0.0.1
    protocol        = tcp
    socket_type     = stream
    wait            = no
    user            = nobody
    redirect        = 127.0.0.1 6743
}
EOF

tee /etc/xinetd.d/vscode-smtp <<EOF
service vscode-https
{
    type            = UNLISTED
    port            = 22
    bind            = 127.0.0.1
    protocol        = tcp
    socket_type     = stream
    wait            = no
    user            = nobody
    redirect        = 127.0.0.1 6722
}
EOF

tee /etc/xinetd.d/vscode-smtp <<EOF
service vscode-https
{
    type            = UNLISTED
    port            = 25
    bind            = 127.0.0.1
    protocol        = tcp
    socket_type     = stream
    wait            = no
    user            = nobody
    redirect        = 127.0.0.1 6725
}
EOF
