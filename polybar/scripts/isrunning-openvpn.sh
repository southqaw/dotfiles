#!/bin/sh

if [ "$(pidof openvpn)" ]; then
    echo " 歷VPN"
else
    echo "%{F#dc322f} 轢VPN"
fi
