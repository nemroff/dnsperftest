# DNS Performance Test

Shell scripts to test the performance of the most popular DNS resolvers from your location, over IPv4 or IPv6.

## Included DNS Providers

The following providers are included by default:

### IPv6

* CloudFlare (`2606:4700:4700::1111` / `2606:4700:4700::1001`)
* Google (`2001:4860:4860::8888` / `2001:4860:4860::8844`)
* Quad9 (`2620:fe::fe` / `2620:fe::fe:9`)
* OpenDNS (`2620:119:35::35`)
* CleanBrowsing (`2a0d:2a00:1::1`)
* Yandex (`2a02:6b8::feed:0ff`)
* AdGuard (`2a00:5a60::ad1:0ff`)
* NeuStar (`2620:74:1b::1:1`)
* NeuStar Threat Protection (`2610:a1:1018::2`)
* NeuStar Family Secure (`2610:a1:1018::3`)

### IPv4

* CloudFlare (`1.1.1.1` / `1.0.0.1`)
* Level3 (`4.2.2.1`)
* Google (`8.8.8.8` / `8.8.4.4`)
* Quad9 (`9.9.9.9` / `149.112.112.112`)
* Freenom (`80.80.80.80`)
* OpenDNS (`208.67.222.123`)
* CleanBrowsing (`185.228.168.168`)
* Yandex (`77.88.8.7`)
* AdGuard (`176.103.130.132`)
* NeuStar (`64.6.64.6`)
* NeuStar Threat Protection (`156.154.70.2`)
* NeuStar Family Secure (`156.154.70.3`)
* Comodo (`8.26.56.26`)
* DNS.Watch (`84.200.69.80`)
* Verisign (`64.6.65.6`)
* OpenNIC (`13.239.157.177`)
* UncensoredDNS (`91.239.100.100`)
* AlternateDNS (`198.101.242.72`)
* NextDNS (`45.90.28.0`)

## Requirements

You need to install bc and dig.

For Ubuntu:

``` sh
 $ sudo apt-get install bc dnsutils
```

For macOS using homebrew:

``` sh
 $ brew install bc bind
```

## Utilization

``` sh
 $ git clone --depth=1 https://github.com/cleanbrowsing/dnsperftest/
 $ cd dnsperftest
 $ bash ./dnstest.sh
Using providers of DNS over IPv4.
               test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cloudflare     1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.10
google         22 ms   1 ms    4 ms    24 ms   1 ms    19 ms   3 ms    56 ms   21 ms   21 ms     17.20
quad9          10 ms   19 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   55 ms     15.40
opendns        39 ms   2 ms    2 ms    20 ms   2 ms    72 ms   2 ms    39 ms   39 ms   3 ms      22.00
cleanbrowsing  11 ms   14 ms   11 ms   11 ms   10 ms   10 ms   11 ms   36 ms   11 ms   13 ms     13.80
yandex         175 ms  209 ms  175 ms  181 ms  188 ms  179 ms  178 ms  179 ms  177 ms  208 ms    184.90
adguard        200 ms  200 ms  200 ms  199 ms  202 ms  200 ms  202 ms  200 ms  199 ms  248 ms    205.00
neustar        2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    2 ms    2 ms    2 ms      1.90
comodo         21 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   21 ms   22 ms   24 ms     22.00
```

Use `dnstest6.sh` to test DNS over IPv6 instead:

```
 $ bash ./dnstest6.sh
Using providers of DNS over IPv6.
               test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cloudflare     1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.10
google         22 ms   1 ms    4 ms    24 ms   1 ms    19 ms   3 ms    56 ms   21 ms   21 ms     17.20
quad9          10 ms   19 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   55 ms     15.40
opendns        39 ms   2 ms    2 ms    20 ms   2 ms    72 ms   2 ms    39 ms   39 ms   3 ms      22.00
cleanbrowsing  11 ms   14 ms   11 ms   11 ms   10 ms   10 ms   11 ms   36 ms   11 ms   13 ms     13.80
yandex         175 ms  209 ms  175 ms  181 ms  188 ms  179 ms  178 ms  179 ms  177 ms  208 ms    184.90
adguard        200 ms  200 ms  200 ms  199 ms  202 ms  200 ms  202 ms  200 ms  199 ms  248 ms    205.00
neustar        2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    2 ms    2 ms    2 ms      1.90
```

To sort with the fastest first, add `sort -k 22 -n` at the end of the command:

```
  $ bash ./dnstest.sh |sort -k 22 -n
Using providers of DNS over IPv4.
               test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cloudflare     1 ms    1 ms    1 ms    4 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.30
norton         2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms      2.00
neustar        2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    2 ms    2 ms    22 ms     3.90
cleanbrowsing  11 ms   23 ms   11 ms   11 ms   11 ms   11 ms   11 ms   13 ms   12 ms   11 ms     12.50
google         4 ms    4 ms    3 ms    21 ms   21 ms   61 ms   3 ms    21 ms   21 ms   22 ms     18.10
opendns        2 ms    2 ms    2 ms    39 ms   2 ms    75 ms   2 ms    21 ms   39 ms   13 ms     19.70
comodo         22 ms   23 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   23 ms     22.20
quad9          10 ms   37 ms   10 ms   10 ms   10 ms   145 ms  10 ms   10 ms   10 ms   20 ms     27.20
yandex         177 ms  216 ms  178 ms  182 ms  186 ms  177 ms  183 ms  174 ms  186 ms  222 ms    188.10
adguard        199 ms  210 ms  200 ms  201 ms  202 ms  202 ms  199 ms  200 ms  198 ms  201 ms    201.20
```

## For Windows users using the Linux subsystem

If you receive an error `$'\r': command not found`, convert the file to a Linux-compatible line endings using:

``` sh
tr -d '\15\32' < dnstest.sh > dnstest-2.sh
```

Then run `bash ./dnstest-2.sh`
