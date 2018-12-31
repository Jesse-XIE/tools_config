
set -x
[ $# -ne 1 ] && echo "Usage: $0 <password>" && exit 1

PASS=$1
go-shadowsocks2 -s "ss://AEAD_CHACHA20_POLY1305:$PASS@:8488" -verbose
