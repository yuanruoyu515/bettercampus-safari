# Chrome Web Store Listing — BetterCampus

> Last Updated: 2026-10-19
> 用途：记录上游 Chrome 发行版及非官方 Safari 移植。此为公开 GitHub 维护仓库；无扩展商店发布计划，不代表上游授权或官方支持。

## Store Listing

**Extension Name**：上游 `BetterCampus (prev. BetterCanvas)`；临时移植清单为 `BetterCampus (Safari Local Port)`，本地承载应用内名称为 `BetterCampus (Safari Installed)`。

**Short Description**：上游原文 `Feature packed extension for Canvas.`

**Detailed Description**：为学校 Canvas 提供主题、深色模式、课程与作业工具，并提供依赖 BetterCampus 账户的学习及日历服务。此为本机个人移植记录，不作为新的商店文案。

**Category**：Productivity（本地记录，未提交）。

**Single Purpose**：个性化学校 LMS 界面并集中管理学习任务。

**Primary Language**：English；含 `zh_CN`、`zh_TW` 等 11 个语言包。

## Graphics & Assets

| Asset | Dimensions | Status | Filename |
|---|---|---|---|
| Store Icon | 128×128 PNG | 从原版提取并验证尺寸 | `safari-extension/icon/icon-128.png` |
| Toolbar icons | 16、32、48 PNG | 从原版提取并验证尺寸 | `safari-extension/icon/` |
| Screenshot 1 | 1280×800 or 640×400 | 未制作商店截图 | — |
| Small Promo Tile | 440×280 | 无发布计划 | — |
| Marquee Promo Tile | 1400×560 | 无发布计划 | — |

### Screenshot Notes

若未来获得权利方授权并发布，需为 Safari 实际运行效果另行制作截图。

## Permissions Justification

| Permission | Type | Justification |
|---|---|---|
| `storage` | permissions | 保存主题、显示偏好、功能设置和登录会话；原版也使用 session 存储。 |
| `tabs` | permissions | 识别已打开的学校标签，打开相关学习页面，将工具栏操作传给页面并支持页面截图功能。 |
| `<all_urls>` | host_permissions | 学校可在任意自定义域名部署 LMS；扩展需识别这些站点并连接其学习页面、日历、文档和所选资源。Safari 中实际访问仍受用户逐站授权控制。 |
| `<all_urls>` | content_scripts | 主脚本识别任意域名上的 LMS；BetterCampus 桥接、日历、主题及文档脚本另有各自限定匹配。 |

Safari 移植未增加权限。`key`、Chrome `update_url`、`use_dynamic_url` 已移除。

## Privacy & Data Use

### Data Collection

**Does the extension collect user data?** 原版包含联网和分析代码，不能声明“不收集”。以下是静态检查结果，非完整商店数据申报。

| Data Type | Collected? | Transmitted Off-Device? | Purpose | Shared with Third Parties? |
|---|---|---|---|---|
| Personally identifiable info | 账户分支处理邮箱与用户资料 | 账户与认证功能会联网 | 登录及服务关联 | 原版 BetterCampus / Supabase 服务；详见上游政策 |
| Health info | 本次未确认 | 未确认 | — | 未确认 |
| Financial info | 有订阅与支付入口，未审计支付处理链 | 取决于原服务 | 原版订阅服务 | 由原服务决定 |
| Authentication info | 本地存储与认证代码存在 | 向原认证服务发请求 | 维持登录 | BetterCampus / Supabase |
| Personal communications | 未完整审计 | 未确认 | — | 未确认 |
| Location | 本次未确认 | 未确认 | — | 未确认 |
| Web history | 读取标签 URL、学校域名 | 分析请求包含学校等属性的代码存在 | 学校识别及原版分析 | 原版分析接收方 |
| User activity | 有安装、首次运行等事件 | 有 PostHog 请求代码 | 原版功能分析 | PostHog |
| Website content | 原版读取课程、作业等 LMS 内容 | 按所用学习服务与功能决定 | 学习管理与工具 | 原版后端及用户选择的连接服务 |

本次仅复制扩展发行文件，未复制浏览器 Cookie、存储、令牌或课程数据。保留的域名包括 `api.bettercampus.com`、`ext.bettercampus.com`、上游 Supabase 主机、`us.i.posthog.com`，以及按功能使用的学校、日历和媒体站点。

### Data Use Certification

未代表原作者勾选数据用途认证。重新发布前必须由权利方确认数据政策、依赖服务及完整申报。

## Privacy Policy

**Privacy Policy URL**：原版官方隐私政策需在正式发布前由权利方核实。本地移植未添加独立在线服务或隐私政策。

## Distribution

**Visibility**：公开 GitHub 源码维护仓库。未提交 Chrome Web Store、Mac App Store 或发布已签名安装包。

现已使用 Xcode 27.1 和普通 Apple ID 的 Personal Team 为 macOS 承载应用及 Safari 扩展进行 Apple Development 签名，并安装启用。已验证“允许未签名的扩展”关闭、完整退出和重新启动 Safari 后扩展仍自动启用，学校页面继续显示 BetterCampus 界面。证书到期前需重新签名；仓库构建配置不含个人团队编号或证书。未公证、未对外发布签名安装包。

应用内扩展的 94 个资源与旧安装版一致；权限和原有联网行为不变。原生承载层采用 Apple 模板，仅提供设置入口与启用状态查询。私钥保留在本机钥匙串，不包含在交付包中。仓库不包含旧安装包或签名私钥。

**Regions**：不适用。

## Developer Info

**Publisher Name**：上游 BetterCampus；本地移植不冒充官方发行。

**Contact Email**：未为本地移植设置公开联系邮箱。

**Support URL**：<https://support.bettercampus.com/>（上游支持，不承诺处理此非官方移植）。

**Homepage URL**：<https://bettercampus.com/>

## Version History

| Version | Date | Changes | Status |
|---|---|---|---|
| 9.8.15.1 | 2026-10-19 | 修复 GraphQL 分批读取、JSON 响应处理、Safari 文档存活验证、未登录同步及 401 刷新；权限不变 | Public source repository; not submitted |
| 9.8.15 local Safari port | 2026-10-19 | 提取本机版本；适配 Safari 清单与管理页入口；保留原作功能和联网行为 | Public source repository; not submitted |

## Review Notes

### Known Issues / Limitations

见 `PORTING_NOTES.md` 和 `VALIDATION.md`。没有自动更新；临时文件夹安装会过期，当前 Apple 签名应用已通过重启测试，但证书到期后需重新签名；账户及高级功能未全部验证；顶层推广收件箱使用 Safari 文档存活挑战兼容 Chrome 字段缺失；跨域推广 iframe renderer 仍受原版限制。扩展、框架、文档和学校来源检查均保留。

### Rejection History

无提交记录。
