
set -x
[ $# -ne 2 ] && echo "Usage: $0 <server> <password>" && exit 1
SERVER=$1
PASS=$2
go-shadowsocks2 -c "ss://AEAD_CHACHA20_POLY1305:$PASS@$SERVER:8488" \
        -verbose -socks :1080 -u -udptun :8053=8.8.8.8:53,:8054=8.8.4.4:53 \
                                     -tcptun :8053=8.8.8.8:53,:8054=8.8.4.4:53
