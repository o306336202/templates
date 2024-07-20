#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <template file> <output directory>"
  exit 1
fi

template=$1
output_dir=$2

if [ ! -f "$template" ]; then
  echo "File does not exist."
  exit 1
fi

if grep -q '"fakeip"' $template; then
  config_name="config_fakeip.json"
else
  config_name="config.json"
fi

declare -A ali=(
  ["doh"]="https://dns.alidns.com/dns-query"
  ["dot"]="tls://dns.alidns.com"
  ["h3"]="h3://dns.alidns.com/dns-query"
)
declare -A dnspod=(
  ["doh"]="https://doh.pub/dns-query"
  ["dot"]="tls://doh.pub"
)

declare -A adguard=(
  ["doh"]="https://94.140.14.140/dns-query"
  ["dot"]="tls://94.140.14.140"
  ["h3"]="h3://94.140.14.140/dns-query"
)
declare -A cloudflare=(
  ["doh"]="https://1.1.1.1/dns-query"
  ["dot"]="tls://1.1.1.1"
  ["h3"]="h3://1.1.1.1/dns-query"
)
declare -A google=(
  ["doh"]="https://8.8.8.8/dns-query"
  ["dot"]="tls://8.8.8.8"
  ["h3"]="h3://8.8.8.8/dns-query"
)

CDN=(
  https://mirror.ghproxy.com/https://raw.githubusercontent.com/senzyo/sing-box-rules/master/
  https://ghproxy.net/https://raw.githubusercontent.com/senzyo/sing-box-rules/master/
  https://fastly.jsdelivr.net/gh/senzyo/sing-box-rules@master/
  https://gcore.jsdelivr.net/gh/senzyo/sing-box-rules@master/
  https://testingcf.jsdelivr.net/gh/senzyo/sing-box-rules@master/
)

Protocol=(doh dot h3)
DNS_China_Server=(ali dnspod)
DNS_Global_Server=(adguard cloudflare google)

function generate() {
  path=$output_dir/$protocol/$dns_china_server/$dns_global_server/$cdn_server
  if [ ! -d "$path" ]; then
    mkdir -p $path
  fi
  jq --arg dns_china "${!dns_china}" --arg dns_global "${!dns_global}" --arg cdn "$cdn" \
    '.dns.servers[] |= if .tag=="国际 DNS" then .address = $dns_global elif .tag=="中国 DNS" then .address = $dns_china else . end | .route.rule_set[].url |= sub("https.*?master\/"; $cdn)' $template >$path/$config_name
  echo "$path/$config_name"
}

for protocol in "${Protocol[@]}"; do
  for dns_china_server in "${DNS_China_Server[@]}"; do
    dns_china="${dns_china_server}[$protocol]"
    [[ -z "${!dns_china}" ]] && continue
    for dns_global_server in "${DNS_Global_Server[@]}"; do
      dns_global="${dns_global_server}[$protocol]"
      [[ -z "${!dns_global}" ]] && continue
      for cdn in "${CDN[@]}"; do
        cdn_server=$(echo "$cdn" | awk -F/ '{print $3}')
        generate
      done
    done
  done
done

dir_count=$(find $output_dir -type d | wc -l)
file_count=$(find $output_dir -type f | wc -l)
echo "Directory Count: $dir_count"
echo "File Count: $file_count"
