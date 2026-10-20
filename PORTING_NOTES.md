# Safari 适配记录

日期：2026-10-19。原版：9.8.15。目标：当前 Mac 的 Safari 27.0.1。

## 变更

1. 将展示名称改为 `BetterCampus (Safari Local Port)`，以便区别原版；本地修复版本为 `9.8.15.1`。承载应用内的复制品名称为 `BetterCampus (Safari Installed)`。
2. 删除 Chrome 商店专用 `key` 和 `update_url`。
3. 删除 `web_accessible_resources` 中的 `use_dynamic_url`，保留资源匹配范围。
4. 声明 Safari 最低版本 16.4（原版使用 `storage.session`）；本次只针对本机 Safari 27 验证，较旧版本未实测。
5. 将后台的 `chrome://extensions` 入口定点替换为本地 `safari-help.html`。
6. 不复制 `_metadata/`；该目录是 Chrome 商店完整性元数据。

保留 Manifest V3、原始 service worker、全部内容脚本、CSS、字体、图片、语言包及工具栏动作。原版已经支持 `browser` / `chrome` 两种命名空间，无须重写调用。未扩大原有 `storage`、`tabs` 和 `<all_urls>` 权限。

## 9.8.15.1 修复

- Canvas GraphQL 查询每批最多 5 项，按别名关联结果；学校原先对大批量请求返回 `max query aliases exceeded`。单批失败或无成绩时保留其他已读作业与成绩。
- 课程卡片、颜色、planner、GraphQL 使用带当前学校会话的 JSON 读取器；校验当前站点 API URL、HTTP 状态，支持 Canvas 的 `while(1);` 前缀。只读请求遇到短暂网络或无效 JSON 可重试一次；写入操作不自动重试。持续无效响应仍显示明确警告，不隐藏服务故障。
- 修复课程卡片 async Promise executor 出错后外层 Promise 一直不结束的问题。
- 顶层存活消息监听器提前注册；后台以存活挑战兼容 Safari 缺失的生命周期字段，且只用文档 ID 定向发送。
- 未登录 BetterCampus 时跳过账户同步；带令牌请求遇到 401 时最多刷新并重试一次，刷新失败仍保留失败结果。
- 没有增加网站或 API 权限，没有复制或写入学校课程、成绩或作业。

## 权限与网站

原版使用 `<all_urls>` 自动发现自定义域名的学校 LMS，因此清单保留该范围。Safari 的实际网站授权由用户控制；可先只允许自己的学校，再按需允许 BetterCampus、Canvas 文档、Google 或 Outlook 日历网站。清单中的权限声明不代表用户已经授予权限。

## 已知限制

- 直接加载资源文件夹的临时扩展会在退出 Safari 或 24 小时后移除。现已提供并安装 Apple Development 签名承载应用，已验证关闭未签名选项并重启 Safari 后仍自动启用；证书到期前需重新签名。早期 ad-hoc 包仍需要未签名开关。实际状态见 `VALIDATION.md`。
- 没有商店自动更新；Chrome 新版本不会自动合入本包。
- Safari 的 `storage.sync` 不做浏览器间同步，原 Chrome 账号和设置没有迁移。
- Safari 缺少 `documentLifecycle` 时，顶层消息使用原版 `CAMPAIGN_DOCUMENT` 存活挑战，仍验证扩展 ID、顶层框架、浏览器提供的文档 ID、学校 URL 和配置域名。挑战只指定精确文档 ID，避免 Safari 拒绝同时指定 `frameId` 和 `documentId`。需 Safari 18.4+ 的文档定向消息支持，旧版 Safari 未验证；推广 iframe 的 renderer 分支仍保留原版严格限制。
- 保留原作的账号、订阅、分析和后端请求；没有绕过服务权限。
- 原版后台包含依赖计时器和全局状态的逻辑，本次未重构整个上游发行包。后台挂起与恢复相关功能仍需实际使用验证。
- 原版后台的图片读取分支使用 `FileReader`，在 service worker 中可能不可用；这属于上游路径，本次未声称图片抓取功能已通过验证。

## 验证

验证结果见 `VALIDATION.md`。静态清单和脚本检查不能替代学校页面及账号功能的实际运行验证。

## 参考

- Apple 兼容性：<https://developer.apple.com/documentation/safariservices/assessing-your-safari-web-extension-s-browser-compatibility>
- Apple 临时安装与运行：<https://developer.apple.com/documentation/safariservices/running-your-safari-web-extension>
- Apple 工程打包：<https://developer.apple.com/documentation/safariservices/packaging-a-web-extension-for-safari>
