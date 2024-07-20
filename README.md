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
url_tpl="https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/google/mirror.ghproxy.com/config.json"  # 配置所用模板的地址
url_dl="$url_gene/config/$url_sub&ua=clashmeta&emoji=1&file=$url_tpl"
echo $url_dl
curl -L -o config.json "$url_dl"
```

在 Android 或 Apple 设备的 sing-box 图形客户端中添加这个最终的 URL 作为订阅链接。

对于 Linux 和 Windows, 阅读 [sing-box on Linux](https://senzyo.net/2024-2/#日常使用) 和 [sing-box on Windows](https://senzyo.net/2024-3/#日常使用)。

至于 [Toperlock/sing-box-subscribe](https://github.com/Toperlock/sing-box-subscribe) 的更多参数信息, 阅读其 [README.md](https://github.com/Toperlock/sing-box-subscribe/blob/main/instructions/README.md)。

## 2. 分类

文件按照 "入站方式 → DNS 协议 → DNS 服务商 → CDN" 进行层级划分。

<details>
<summary>目录结构参考</summary>

```
.
├── mixed
│   ├── DoH
│   │   ├── AdGuard
│   │   │   ├── fastly.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── gcore.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── ghproxy.net
│   │   │   │   └── config.json
│   │   │   ├── mirror.ghproxy.com
│   │   │   │   └── config.json
│   │   │   └── testingcf.jsdelivr.net
│   │   │       └── config.json
│   │   ├── Cloudflare
│   │   │   ├── fastly.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── gcore.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── ghproxy.net
│   │   │   │   └── config.json
│   │   │   ├── mirror.ghproxy.com
│   │   │   │   └── config.json
│   │   │   └── testingcf.jsdelivr.net
│   │   │       └── config.json
│   │   └── Google
│   │       ├── fastly.jsdelivr.net
│   │       │   └── config.json
│   │       ├── gcore.jsdelivr.net
│   │       │   └── config.json
│   │       ├── ghproxy.net
│   │       │   └── config.json
│   │       ├── mirror.ghproxy.com
│   │       │   └── config.json
│   │       └── testingcf.jsdelivr.net
│   │           └── config.json
│   ├── DoT
│   │   ├── AdGuard
│   │   │   ├── fastly.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── gcore.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── ghproxy.net
│   │   │   │   └── config.json
│   │   │   ├── mirror.ghproxy.com
│   │   │   │   └── config.json
│   │   │   └── testingcf.jsdelivr.net
│   │   │       └── config.json
│   │   ├── Cloudflare
│   │   │   ├── fastly.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── gcore.jsdelivr.net
│   │   │   │   └── config.json
│   │   │   ├── ghproxy.net
│   │   │   │   └── config.json
│   │   │   ├── mirror.ghproxy.com
│   │   │   │   └── config.json
│   │   │   └── testingcf.jsdelivr.net
│   │   │       └── config.json
│   │   └── Google
│   │       ├── fastly.jsdelivr.net
│   │       │   └── config.json
│   │       ├── gcore.jsdelivr.net
│   │       │   └── config.json
│   │       ├── ghproxy.net
│   │       │   └── config.json
│   │       ├── mirror.ghproxy.com
│   │       │   └── config.json
│   │       └── testingcf.jsdelivr.net
│   │           └── config.json
│   └── H3
│       ├── AdGuard
│       │   ├── fastly.jsdelivr.net
│       │   │   └── config.json
│       │   ├── gcore.jsdelivr.net
│       │   │   └── config.json
│       │   ├── ghproxy.net
│       │   │   └── config.json
│       │   ├── mirror.ghproxy.com
│       │   │   └── config.json
│       │   └── testingcf.jsdelivr.net
│       │       └── config.json
│       ├── Cloudflare
│       │   ├── fastly.jsdelivr.net
│       │   │   └── config.json
│       │   ├── gcore.jsdelivr.net
│       │   │   └── config.json
│       │   ├── ghproxy.net
│       │   │   └── config.json
│       │   ├── mirror.ghproxy.com
│       │   │   └── config.json
│       │   └── testingcf.jsdelivr.net
│       │       └── config.json
│       └── Google
│           ├── fastly.jsdelivr.net
│           │   └── config.json
│           ├── gcore.jsdelivr.net
│           │   └── config.json
│           ├── ghproxy.net
│           │   └── config.json
│           ├── mirror.ghproxy.com
│           │   └── config.json
│           └── testingcf.jsdelivr.net
│               └── config.json
└── tun
    ├── DoH
    │   ├── AdGuard
    │   │   ├── fastly.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── gcore.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── ghproxy.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── mirror.ghproxy.com
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   └── testingcf.jsdelivr.net
    │   │       ├── config_fakeip.json
    │   │       └── config.json
    │   ├── Cloudflare
    │   │   ├── fastly.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── gcore.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── ghproxy.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── mirror.ghproxy.com
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   └── testingcf.jsdelivr.net
    │   │       ├── config_fakeip.json
    │   │       └── config.json
    │   └── Google
    │       ├── fastly.jsdelivr.net
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       ├── gcore.jsdelivr.net
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       ├── ghproxy.net
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       ├── mirror.ghproxy.com
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       └── testingcf.jsdelivr.net
    │           ├── config_fakeip.json
    │           └── config.json
    ├── DoT
    │   ├── AdGuard
    │   │   ├── fastly.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── gcore.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── ghproxy.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── mirror.ghproxy.com
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   └── testingcf.jsdelivr.net
    │   │       ├── config_fakeip.json
    │   │       └── config.json
    │   ├── Cloudflare
    │   │   ├── fastly.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── gcore.jsdelivr.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── ghproxy.net
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   ├── mirror.ghproxy.com
    │   │   │   ├── config_fakeip.json
    │   │   │   └── config.json
    │   │   └── testingcf.jsdelivr.net
    │   │       ├── config_fakeip.json
    │   │       └── config.json
    │   └── Google
    │       ├── fastly.jsdelivr.net
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       ├── gcore.jsdelivr.net
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       ├── ghproxy.net
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       ├── mirror.ghproxy.com
    │       │   ├── config_fakeip.json
    │       │   └── config.json
    │       └── testingcf.jsdelivr.net
    │           ├── config_fakeip.json
    │           └── config.json
    └── H3
        ├── AdGuard
        │   ├── fastly.jsdelivr.net
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   ├── gcore.jsdelivr.net
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   ├── ghproxy.net
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   ├── mirror.ghproxy.com
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   └── testingcf.jsdelivr.net
        │       ├── config_fakeip.json
        │       └── config.json
        ├── Cloudflare
        │   ├── fastly.jsdelivr.net
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   ├── gcore.jsdelivr.net
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   ├── ghproxy.net
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   ├── mirror.ghproxy.com
        │   │   ├── config_fakeip.json
        │   │   └── config.json
        │   └── testingcf.jsdelivr.net
        │       ├── config_fakeip.json
        │       └── config.json
        └── Google
            ├── fastly.jsdelivr.net
            │   ├── config_fakeip.json
            │   └── config.json
            ├── gcore.jsdelivr.net
            │   ├── config_fakeip.json
            │   └── config.json
            ├── ghproxy.net
            │   ├── config_fakeip.json
            │   └── config.json
            ├── mirror.ghproxy.com
            │   ├── config_fakeip.json
            │   └── config.json
            └── testingcf.jsdelivr.net
                ├── config_fakeip.json
                └── config.json

117 directories, 135 files
```

</details>

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

DNS 协议使用 `DNS over HTTPS` 或 `DNS over HTTP3` 或 `DNS over TLS`, 更多 DNS 协议与格式参考 [sing-box](https://sing-box.sagernet.org/zh/configuration/dns/server/#address) 文档。

### 2.3 DNS 服务商

所有模板的国内 DNS 都使用 `阿里 DNS`, `国际 DNS` 使用 `AdGuard DNS`, `Cloudflare DNS`, `Google DNS` 中的一个。

更多 DNS 服务商 [参考](https://senzyo.net/2022-22/)。

对于阿里 DNS, 2024 年 9 月 30 日 24 时起, [公共 DNS 免费版接入限速](https://help.aliyun.com/zh/dns/public-dns-free-version-access-speed-limit-notification), 升级到公共 DNS [付费版](https://help.aliyun.com/zh/dns/pricing-overview) 后, 每月有 1000 万次的免费解析额度, 足够个人使用, 只要不超出免费额度就不会产生费用。

然后可修改模板中 `阿里 DNS` 的 `address` 为自己的 DNS 地址。

```json
"dns": {
  "servers": [
    {
      "tag": "国际 DNS",
      "address": "h3://8.8.8.8/dns-query",
      "detour": "🚀 默认出站"
    },
    {
      "tag": "阿里 DNS",
      "address": "h3://dns.alidns.com/dns-query",
      // "address": "h3://12345.alidns.com/dns-query",
      "address_resolver": "ISP DNS",
      "detour": "🐢 直连"
    },
    {
      "tag": "ISP DNS",
      "address": "local",
      "detour": "🐢 直连"
    }
...
  ],
...
},
```

<details>
<summary>或者用 DNSPod</summary>

开通腾讯云 Public DNS [专业版](https://docs.dnspod.cn/public-dns/pricing-description/), 每月有 300 万次的免费解析额度。

</details>

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
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/google/mirror.ghproxy.com/config.json
```

如果要使用 [FakeIP](https://sing-box.sagernet.org/zh/configuration/dns/fakeip/), 选择:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/google/mirror.ghproxy.com/config_fakeip.json
```

或者使用入站方式为 `mixed` 的模板:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/mixed/h3/google/mirror.ghproxy.com/config.json
```

### 3.2 Android 和 Apple

只推荐使用入站方式为 `tun` 的模板:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/google/mirror.ghproxy.com/config.json
```

如果要使用 [FakeIP](https://sing-box.sagernet.org/zh/configuration/dns/fakeip/), 选择:

```
https://raw.githubusercontent.com/senzyo/sing-box-templates/public/tun/h3/google/mirror.ghproxy.com/config_fakeip.json
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
