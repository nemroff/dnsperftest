#!/usr/bin/env bash

command -v bc > /dev/null || { echo "bc was not found. Please install bc."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "dig was not found. Please install dnsutils."; exit 1; }



CURRENTNS=$(grep ^nameserver /etc/resolv.conf | cut -d " " -f 2)

if [[ $(basename "$0") == "dnstest6.sh" ]]; then
	echo "Using providers of DNS over IPv6."
	PROVIDERS="
2606:4700:4700::1111#cloudflare
2606:4700:4700::1001#cloudflare2
2001:4860:4860::8888#google
2001:4860:4860::8844#google2
2620:fe::fe#quad9
2620:fe::fe:9#quad9_2
2620:119:35::35#opendns
2a0d:2a00:1::1#cleanbrowsing
2a02:6b8::feed:0ff#yandex
2a00:5a60::ad1:0ff#adguard
2620:74:1b::1:1#neustar
2610:a1:1018::2#neustar_tp
2610:a1:1018::3#neustar_fs
"
    CURRENTNS=$(echo "$CURRENTNS" | grep ":")
else
	echo "Using providers of DNS over IPv4."
	PROVIDERS="
1.1.1.1#cloudflare
1.0.0.1#cloudflare2
4.2.2.1#level3
8.8.8.8#google
8.8.4.4#google2
9.9.9.9#quad9
149.112.112.112#quad9_2
80.80.80.80#freenom
208.67.222.123#opendns
185.228.168.168#cleanbrowsing
77.88.8.7#yandex
176.103.130.132#adguard
64.6.64.6#neustar
156.154.70.2#neustar_tp
156.154.70.3#neustar_fs
8.26.56.26#comodo
84.200.69.80#dns.watch
64.6.65.6#verisign
13.239.157.177#opennic
91.239.100.100#uncensoreddns
198.101.242.72#alternatedns
45.90.28.0#nextdns
"
    CURRENTNS=$(echo "$CURRENTNS" | grep -v ":")
fi

NAMESERVERS=""

for p in $CURRENTNS; do
    preverse=$(dig +short +time=1 +tries=1 -x $p | sed 's/\.$//')
    NAMESERVERS="${NAMESERVERS:+$NAMESERVERS$'\n'}$p#* ${preverse:-${p}}"
done

# Domains to test. Duplicated domains are ok
DOMAINS2TEST="www.google.com amazon.com facebook.com www.youtube.com www.reddit.com  wikipedia.org twitter.com gmail.com www.google.com whatsapp.com"


totaldomains=0
printf "%-21s" ""
for d in $DOMAINS2TEST; do
    totaldomains=$((totaldomains + 1))
    printf "%-8s" "test$totaldomains"
done
printf "%-8s" "Average"
echo ""


for p in $NAMESERVERS $PROVIDERS; do
    pip=${p%%#*}
    pname=${p##*#}
    ftime=0

    printf "%-21s" "$pname"
    for d in $DOMAINS2TEST; do
        ttime=$($dig +tries=1 +time=2 +stats @"$pip" "$d" |grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2)
        if [ -z "$ttime" ]; then
            #let's have time out be 1s = 1000ms
            ttime=1000
        elif [ "x$ttime" = "x0" ]; then
            ttime=1
      fi

        printf "%-8s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
    avg=$(bc -lq <<< "scale=2; $ftime/$totaldomains")

    printf "%7s" "$avg"
    echo ""
done


exit 0;
