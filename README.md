# BetterCampus Safari

BetterCampus 的非官方 Safari 移植及兼容性修复，供后续维护和个人构建使用。基于 Chrome 发行版 **9.8.15**，当前移植版 **9.8.15.1**。

原扩展提供 Canvas LMS 主题、课程成绩和作业工具。本仓库保留上游发行资源，修复 Safari 下的 Canvas JSON 读取、GraphQL 批量查询和扩展消息兼容问题。它不是 BetterCampus 官方项目，也不是上游完整开发源码；主要逻辑来自已打包的 JavaScript。

## 已实现

- 适配 Safari Manifest V3，保留内容脚本、图片、字体及语言包。
- 成绩 GraphQL 请求每批最多 5 项，按别名合并，避免服务端查询别名数量限制。
- 校验当前学校来源、HTTP 状态和 JSON 内容，兼容 Canvas JSON 前缀；只读请求有限重试，写入不自动重试。
- 兼容 Safari 文档消息行为，保留精确文档和页面来源验证。
- 未登录时跳过账户同步，401 时最多刷新令牌并重试一次。
- 提供 macOS Xcode 承载工程。维护者已在 macOS 27.0.1 / Safari 27.0.1 上使用免费 Apple ID 的 Apple Development 签名，验证关闭“允许未签名的扩展”、完全退出并重启 Safari 后仍能自动启用。

## 构建并签名

需要 Mac、完整 Xcode、Python 3。先打开 Xcode 完成首次设置，并在 Settings → Apple Accounts 登录自己的 Apple ID。

```sh
git clone https://github.com/yuanruoyu515/bettercampus-safari.git
cd bettercampus-safari
python3 scripts/prepare.py
```

打开 `AppleSignedXcode/BetterCampus Safari.xcodeproj`，为应用和扩展两个 Target 选择自己的 Team。可通过 Xcode 构建，或把自己的 Team ID 传给脚本：

```sh
TEAM_ID=YOUR_TEAM_ID ./scripts/build.sh
```

Xcode 可能需要创建 Apple Development 证书，系统认证和账号条款由本人完成。脚本不导出私钥、不自动安装应用、不修改 Safari 安全设置。

构建结果：`Build/Build/Products/Release/BetterCampus Safari.app`。把应用放到固定的“应用程序”目录，打开一次并进入 Safari 扩展设置启用，再按实际需要授权网站。保留应用即可，无需每次运行它。

免费开发签名用于个人开发和测试，不是通用发行签名。证书到期前需要重新构建、签名并替换应用；请检查自己证书和实际生成描述文件的期限，不要假定所有环境都与维护者的测试相同。已签名安装包未放入此仓库，各自使用自己的签名账号。

仅检查本机构建、不使用签名账号：

```sh
./scripts/build.sh --unsigned
```

未签名构建不能替代上面的 Apple 签名安装流程。

## 修改与检查

**只修改 `safari-extension/` 中的扩展资源**，不要编辑 Xcode 下自动生成的 Resources。`scripts/prepare.py` 和构建脚本会重新复制资源，并仅将安装版的显示名称改为 `BetterCampus (Safari Installed)`。

```sh
node tests/regression.cjs
```

使用 Node.js 22 或更新版本运行现有回归检查，测试使用合成数据，不访问真实学校或账户。修改消息、JSON 或成绩查询逻辑后，先运行回归检查，再构建并在自己有权使用的学校页面验证。

| 路径 | 用途 |
| --- | --- |
| `safari-extension/` | 唯一维护的扩展资源目录 |
| `AppleSignedXcode/` | Apple 模板生成并修正标识的 macOS 工程 |
| `scripts/` | 资源准备、Apple 签名和无签名编译 |
| `tests/regression.cjs` | 网络响应、批量成绩、消息身份和同步回归检查 |
| `native/` | 早期仅依赖 Command Line Tools 的 ad-hoc 承载应用，作为备用实现 |
| `PORTING_NOTES.md` | 具体适配和已知限制 |
| `VALIDATION.md` | 已完成的验证与边界 |
| `SOURCE.json` | 上游版本、文件哈希和修改范围 |
| `CHROMEWEBSTORE.md` | 上游扩展权限和数据使用记录，不是商店发布申请 |

早期 ad-hoc 构建仍依赖 Safari 未签名开关；直接加载文件夹会受 Safari 临时扩展期限限制。日常使用优先采用上述 Xcode 签名构建。

## 账户、数据及更新

没有复制浏览器 Cookie、登录令牌、扩展存储或学校数据。Safari 和 BetterCampus 账户需各自登录；主题恢复由上游账户服务决定。

保留原版 BetterCampus、Supabase、PostHog 及按功能发起的学校和日历请求。没有绕过账户、订阅或付费权限。Safari 网站授权仍由使用者控制。

没有自动合并 Chrome 上游更新。更新上游打包文件时，需要重新审查并应用本仓库的兼容性修复，运行回归检查及真实 Safari 验证。

## 来源

原作及资源归 BetterCampus 和各自权利人所有，见 [THIRD_PARTY.md](THIRD_PARTY.md)。本仓库未给上游代码添加新的开源许可证，不表示获得了上游的官方支持或重新授权。

- [BetterCampus](https://bettercampus.com/)
- [原 Chrome 商店扩展](https://chromewebstore.google.com/detail/cndibmoanboadcifjkjbdpjgfedanolh)
- [Apple：运行 Safari Web Extension](https://developer.apple.com/documentation/safariservices/running-your-safari-web-extension)
- [Apple：发行 Safari Web Extension](https://developer.apple.com/documentation/safariservices/distributing-your-safari-web-extension)
- [PortKit 的免费开发签名说明](https://github.com/Vatsal057/chrome-to-safari#before-you-start-a-free-signing-certificate)：本项目签名路线参考；未执行或复制其转换脚本。
