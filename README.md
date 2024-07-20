<p align="center">
    <img src="https://sing-box.sagernet.org/assets/icon.svg" width="100px" align="center" />
    <h2 align="center">sing-box-templates</h2>
    <p align="center">
        自己用的一些 <a href="https://sing-box.sagernet.org/zh/">sing-box</a> 配置文件模板, 支持 <a href="https://github.com/Toperlock/sing-box-subscribe">Toperlock/sing-box-subscribe</a> 远程调用。
    </p>
</p><br />

- [1. 使用示例](#1-使用示例)
- [2. 分类](#2-分类)
  - [2.1 入站方式](#21-入站方式)
    - [2.1.1 tun 入站](#211-tun-入站)
    - [2.1.2 mixed 入站](#212-mixed-入站)
  - [2.2 DNS 协议](#22-dns-协议)
  - [2.3 DNS 服务商](#23-dns-服务商)
    - [2.3.1 Ali DNS](#231-ali-dns)
    - [2.3.2 DNSPod](#232-dnspod)
  - [2.4 CDN](#24-cdn)
- [3 模板推荐](#3-模板推荐)
  - [3.1 Linux 和 Windows](#31-linux-和-windows)
  - [3.2 Android 和 Apple](#32-android-和-apple)
- [4. 注意事项](#4-注意事项)
  - [4.1 下载进程分流](#41-下载进程分流)
  - [4.2 TUN 模式的问题](#42-tun-模式的问题)

## 1. 使用示例

```bash
#!/bin/bash

url_gene="https://a.com"  # 生成配置的后端地址
url_sub="https://b.com"   # 来自机场的订阅链接
url_tpl="https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/ali/google/mirror.ghproxy.com/config.json"  # 配置所用模板的地址
url_dl="$url_gene/config/$url_sub&ua=clashmeta&emoji=1&file=$url_tpl"
echo $url_dl
curl -L -o config.json "$url_dl"
```

在 Android 或 Apple 设备的 sing-box 图形客户端中添加这个最终的 URL 作为订阅链接。

对于 Linux 和 Windows, 阅读 [sing-box on Linux](https://senzyo.net/2024-2/#日常使用) 和 [sing-box on Windows](https://senzyo.net/2024-3/#日常使用)。

至于 [Toperlock/sing-box-subscribe](https://github.com/Toperlock/sing-box-subscribe) 的更多参数信息, 阅读其 [README.md](https://github.com/Toperlock/sing-box-subscribe/blob/main/instructions/README.md)。

## 2. 分类

文件的存储路径按照 "入站方式 → DNS 协议 → 中国 DNS 服务商 → 国际 DNS 服务商 → CDN" 进行层级划分。

### 2.1 入站方式

#### 2.1.1 tun 入站

```json
"inbounds": [
  {
    "type": "tun",
    "inet4_address": "172.19.0.1/30",
    "inet6_address": "fdfe:dcba:9876::1/126",
    "gso": false,
    "auto_route": true,
    "strict_route": true,
    "endpoint_independent_nat": false,
    "stack": "mixed",
    "exclude_package": ["com.android.captiveportallogin"],
    "platform": {
      "http_proxy": {
        "enabled": true,
        "server": "127.0.0.1",
        "server_port": 7890
      }
    },
    "sniff": true,
    "sniff_override_destination": false
  },
  {
    "type": "mixed",
    "listen": "::",
    "listen_port": 7890,
    "sniff": true,
    "sniff_override_destination": false
  }
],
```

#### 2.1.2 mixed 入站

```json
"inbounds": [
  {
    "type": "mixed",
    "listen": "::",
    "listen_port": 7890,
    "sniff": true,
    "sniff_override_destination": false
  }
],
```

### 2.2 DNS 协议

DNS 协议使用 `DNS over HTTPS` 或 `DNS over TLS` 或 `DNS over HTTP3`, 更多 DNS 协议与格式参考 [sing-box](https://sing-box.sagernet.org/zh/configuration/dns/server/#address) 文档。

### 2.3 DNS 服务商

`中国 DNS` 包括 `Ali DNS` 和 `DNSPod`。

`国际 DNS` 包括 `AdGuard DNS`, `Cisco OpenDNS`, `Cloudflare DNS` 和 `Google DNS`。

更多 DNS 服务商 [参考](https://senzyo.net/2022-22/)。

#### 2.3.1 Ali DNS

根据 [公共 DNS 免费版接入限速](https://help.aliyun.com/zh/dns/public-dns-free-version-access-speed-limit-notification), **单 IP 访问量** 超过 **20 QPS**, **UDP/TCP** 流量超过 **2000 bps** 将被限速。
升级到公共 DNS [付费版](https://help.aliyun.com/zh/dns/pricing-overview), 每月有 **1000 万次** 的免费解析额度。

#### 2.3.2 DNSPod

根据 [DoH 与 DoT 说明](https://docs.dnspod.cn/public-dns/dot-doh/), **单个域名解析调用频率** 限制为 **20 QPS**。
开通腾讯云 Public DNS [专业版](https://docs.dnspod.cn/public-dns/pricing-description/), 每月有 **300 万次** 的免费解析额度。

```json
"dns": {
  "servers": [
    {
      "tag": "国际 DNS",
      "address": "h3://dns.google/dns-query",
      "address_resolver": "中国 DNS",
      "detour": "🚀 默认出站"
    },
    {
      "tag": "中国 DNS",
      "address": "h3://dns.alidns.com/dns-query",
      // 可修改 address 为自己的专属地址
      "address_resolver": "系统 DNS",
      "detour": "🐢 直连"
    },
    {
      "tag": "系统 DNS",
      "address": "local",
      "detour": "🐢 直连"
    }
...
  ],
...
},
```

### 2.4 CDN

仅影响客户端下载规则集的速度。

```json
"route": {
...
  "rule_set": [
...
    {
      "tag": "download-process",
      "type": "remote",
      "format": "binary",
      "url": "https://mirror.ghproxy.com/https://raw.githubusercontent.com/senzyo/sing-box-rules/master/download-process.srs",
      "download_detour": "🐢 直连",
      "update_interval": "3d"
    },
...
  ]
}
```

规则源地址举例: 

```
https://raw.githubusercontent.com/senzyo/sing-box-rules/master/download-process.srs
```

CDN 格式列举:

```
https://mirror.ghproxy.com/https://raw.githubusercontent.com/senzyo/sing-box-rules/master/download-process.srs
```

```
https://ghproxy.net/https://raw.githubusercontent.com/senzyo/sing-box-rules/master/download-process.srs
```

```
https://fastly.jsdelivr.net/gh/senzyo/sing-box-rules@master/download-process.srs
```

```
https://gcore.jsdelivr.net/gh/senzyo/sing-box-rules@master/download-process.srs
```

```
https://testingcf.jsdelivr.net/gh/senzyo/sing-box-rules@master/download-process.srs
```

可自行替换模板中使用的 CDN, 替换前推荐对这些 CDN 的域名进行 [网站测速](https://www.itdog.cn/http/)。不推荐 `cdn.jsdelivr.net`。

## 3 模板推荐

### 3.1 Linux 和 Windows

推荐使用入站方式为 `tun` 的模板:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/ali/google/mirror.ghproxy.com/config.json
```

如果要使用 [FakeIP](https://sing-box.sagernet.org/zh/configuration/dns/fakeip/), 选择:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/ali/google/mirror.ghproxy.com/config_fakeip.json
```

或者使用入站方式为 `mixed` 的模板:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/mixed/h3/ali/google/mirror.ghproxy.com/config.json
```

### 3.2 Android 和 Apple

只推荐使用入站方式为 `tun` 的模板:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/ali/google/mirror.ghproxy.com/config.json
```

如果要使用 [FakeIP](https://sing-box.sagernet.org/zh/configuration/dns/fakeip/), 选择:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/ali/google/mirror.ghproxy.com/config_fakeip.json
```

## 4. 注意事项

### 4.1 下载进程分流

由于暂时无法准确分流 BitTorrent 流量, 干脆匹配 [下载软件的进程](https://raw.githubusercontent.com/senzyo/sing-box-rules/master/downloader.json) 来一刀切。使用 Bittorrent 方式下载时, 手动切换 `📥 Downloader` 分组的策略, 改用 `🐢 直连`。

### 4.2 TUN 模式的问题

根据 [issue#883](https://github.com/SagerNet/sing-box/issues/883), 如果在 TUN 模式下无法使用进行 SSH 访问, , 需要关闭严格路由:

```json
"inbounds": [
  {
    "type": "tun",
...
    "strict_route": false,
...
  },
...
],
```

如果关闭了严格路由, Linux 平台在 TUN 模式下还是无法使用 IPv6 进行 SSH 访问, 根据 [issue#458](https://github.com/SagerNet/sing-box/issues/458) 得知:

> 由于技术限制, 在 Linux 平台中 tun 的自动路由会阻止 IPv6 入站连接, 您可以选择手动配置路由。
