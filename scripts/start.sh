#!/bin/bash

source /etc/profile

cd $(cd "$(dirname "$0")";pwd)

curl --connect-timeout 60 -s -o white_domain_list.php https://raw.githubusercontent.com/ydddj/dead-horse/master/scripts/white_domain_list.php

php make-white-list.php

cd ..
sed 's/^\([.0-9A-Za-z\-]\+\)$/address \/\1\/-/g' anti-ad-white-list.txt >anti-ad-white-for-smartdns.txt

echo '#RULE-SET,AntiAd,DIRECT' >anti-ad-white-for-clash.yaml
echo 'payload:' >>anti-ad-white-for-clash.yaml
sed "s/^\([.0-9A-Za-z\-]\+\)$/  - '+.\1'/g" anti-ad-white-list.txt >>anti-ad-white-for-clash.yaml
