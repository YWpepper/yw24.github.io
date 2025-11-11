---
layout: post
title: 'how_many_bugs_Nov'
date: 2025-11-31
author: pepper
tags: [Windows, Note]
comments: true
toc: true
pinned: false
---

记录11月有价值的bug。
<!-- more -->
#### 1. 语雀的图片

语雀的图片在 GitHub 页面上无法显示的原因主要有以下几点：

1. 跨域（CORS）限制 🔒
语雀的图片服务器配置了 CORS 策略，限制了来自其他域名（如 GitHub Pages）的访问请求。浏览器出于安全考虑会阻止这些跨域请求。

2. 防盗链机制 🛡️
语雀可能实施了防盗链措施，检查 HTTP 请求头中的 Referer 字段。当从 GitHub Pages 访问图片时，Referer 不是语雺域名，请求会被拒绝。

3. 域名白名单 ✅
语雀的服务器只允许特定域名访问其资源，GitHub Pages 的域名不在白名单中。

方案一：下载图片到本地仓库（推荐）

方案二：使用图片代理服务，使用免费的图片代理服务绕过限制：

```bash
<img src="https://images.weserv.nl/?url=cdn.nlark.com/yuque/0/2025/png/..." width="70%">
```

方案三：使用 GitHub 提供的 CDN

```bash
<img src="https://raw.githubusercontent.com/YWpepper/HomePage/master/images/image-name.png" width="70%">
```

---
