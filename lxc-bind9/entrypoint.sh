#!/bin/sh
set -e

# Wenn das Secret aus Doppler (Environment Variable) vorhanden ist, schreibe die Config
if [ -n "$BIND9_TSIG_SECRET" ]; then
    echo "Erstelle named.conf.key aus BIND9_TSIG_SECRET..."
    cat > /etc/bind/named.conf.key <<EOF
key "BIND9_TSIG_SECRET" {
        algorithm hmac-sha256;
        secret "$BIND9_TSIG_SECRET";
};
EOF
fi

# Führe den ursprünglichen Start-Befehl aus (startet bind9)
# Der Standard-Entrypoint des Images wird hierdurch ersetzt, 
# daher rufen wir direkt das auf, was das Image normalerweise tun würde.
# Bei ubuntu/bind9 ist das oft direkt der Daemon oder ein Wrapper.
# Wir starten hier einfach den Befehl, der als CMD übergeben wird (oder default).

exec "$@"
