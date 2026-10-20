# 验证记录

移植版 9.8.15.1 基于上游 9.8.15。手动验证环境：macOS 27.0.1、Safari 27.0.1、Xcode 27.1（27A9275）。

## 扩展逻辑

- 原版大量成绩别名合在一次 GraphQL 查询时，测试学校返回 HTTP 200，但只含 `errors: max query aliases exceeded`，随后触发对 undefined 的 Object.keys。改为每批最多 5 项并按别名合并后，学校页面的一轮诊断为 8 次 GraphQL 请求、0 次失败网络请求。
- 新页面未再出现原报告中的 planner fetch、JSON SyntaxError、Object.keys 或 sync Error applying 错误；课程、成绩和待办继续显示。
- 顶层消息通过 Safari 页面身份与存活检查；没有放宽其他扩展、子框架或学校来源校验。
- 现有 Node 回归检查覆盖 JSON 与 Canvas 前缀、当前来源、Cookie/Accept 头、有限只读重试、不重试写入、47 项成绩的 10 批查询、空结果、部分失败、消息身份与 401 刷新。
- 8 个 JavaScript 文件曾通过 Node 和本机 JavaScriptCore 语法检查。

## 签名与重启

- 使用 Apple 自带 packager 生成 Objective-C macOS 工程，保留应用标识 `local.bettercampus.safariport` 和扩展标识 `local.bettercampus.safariport.Extension`。
- Release 构建通过，应用与内嵌 appex 的 codesign 严格校验通过，证书链为 Apple Development → Apple Worldwide Developer Relations Certification Authority → Apple Root CA。
- 原生应用及扩展启用 App Sandbox / Hardened Runtime。Apple 模板承载层不新增原生联网业务或特权服务。
- 测试构建与早期安装版的 94 个内嵌扩展资源逐字节一致；没有为签名修改扩展权限或逻辑。
- 维护者测试证书有效期约一年，构建没有嵌入式 provisioning profile。该结论只描述测试构建，其他人应检查自己的证书和构建结果。
- 关闭 Safari“允许未签名的扩展”，完全退出并确认主进程结束，再重新启动。扩展仍启用，未签名开关仍关闭，学校 Dashboard 继续显示 BetterCampus 侧栏、成绩和待办。

## 边界

未修改、提交或勾选学校作业与成绩。没有复制浏览器账户存储、Cookie 或令牌。未验证所有账户、订阅、付费及日历功能，未在其他 Mac 实测。

上游网页面板可能显示版本更新提示；Chrome 更新不会自动合入本仓库。开发证书不是永久有效；本仓库不提供可在所有 Mac 直接运行的公证发行包。

公开记录省略个人账号、团队编号、本机路径、学校域名及课程信息。

## 公开仓库准备检查

- 现有 `node tests/regression.cjs` 全部通过。
- 通用资源准备脚本及 `scripts/build.sh --unsigned` 在本机完整编译通过。
- Shell 脚本语法检查通过，工程包含的资源从唯一维护目录生成。
- 扫描未发现个人本机路径、签名团队编号、私人邮箱、学校域名、私钥或 GitHub 令牌。上游包中的 Supabase JWT 均为匿名客户端配置，未复制任何用户会话。
- 仓库排除构建产物、签名证书、密钥、环境变量文件及 Xcode 用户设置。
