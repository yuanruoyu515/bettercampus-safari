# BetterCampus Safari

BetterCampus 的非官方 Safari 移植及兼容性修复，供后续维护和个人构建使用。基于 Chrome 发行版 **9.8.15**，当前移植版 **9.8.15.1**。

原扩展提供 Canvas LMS 主题、课程成绩和作业工具。本仓库保留上游发行资源，修复 Safari 下的 Canvas JSON 读取、GraphQL 批量查询和扩展消息兼容问题。它不是 BetterCampus 官方项目，也不是上游完整开发源码；主要逻辑来自已打包的 JavaScript。

> **版权与授权状态：** 本仓库包含第三方发行代码及资源，目前未确认上游对本次公开再分发的明示授权。公开可见、标明来源、个人使用或非商业研究的目的，均不等于获得复制、修改或再分发许可，也不当然构成合理使用。下面的声明不能补足缺失的授权或保证不存在侵权风险。使用、修改或分发前，请先核实相应权利及适用条款。

## 版权、商标与使用说明

### 非官方项目

本项目由独立维护者进行 Safari 兼容性研究和个人维护，与 BetterCampus、Apple、Google、Instructure、学校及其他所提及的服务提供者不存在本仓库所能证明的隶属、合作、赞助、认证或背书关系。不能将本仓库视为这些主体的官方发行、官方支持渠道或服务承诺。

BetterCampus、BetterCanvas、Safari、Chrome、Canvas 等名称及相关标识归各自权利人所有。项目中提及这些名称用于说明来源、兼容对象和操作步骤，不表示取得商标许可。仓库内保留的上游图标及品牌素材也不因此获得新的使用许可；请勿借此冒充官方、误导用户或暗示官方背书。

### 第三方代码及资源的权利

上游 JavaScript、样式、图片、视频、字体、语言包和其他资源的权利仍归各自权利人所有；维护者只描述本仓库的适配工作，不主张取得这些第三方内容的所有权。来源、版本、文件哈希和修改范围见 [SOURCE.json](SOURCE.json)、[THIRD_PARTY.md](THIRD_PARTY.md) 和 [PORTING_NOTES.md](PORTING_NOTES.md)。

本仓库没有把上游内容重新许可为 MIT、Apache 或其他开源许可证，也未提供覆盖整个仓库的统一开源授权。某个组件附带的许可证仅适用于其明确覆盖的内容，例如字体目录中的 [OFL.txt](safari-extension/fonts/OFL.txt)，不能扩展解释为整个扩展的授权。原有版权通知、许可文本及署名应予保留。

能从 Chrome 商店安装、能查看发行代码或能在 GitHub 查看／Fork，不表示取得任意修改、分发、销售、重新上架或商标使用的权利。GitHub 站内功能与内容许可的区别见 [GitHub 官方许可说明](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)。这同样不意味着上传者已获得第三方授权。

### 使用和再分发边界

本项目的用途说明仅描述维护目的，不是对第三方内容的授权。使用者与维护者均应遵守适用法律、原有许可证，以及所使用的软件商店、Apple 开发者服务、学校和第三方服务的适用条款。个人用途、非商业用途或“仅供学习交流”的声明不能自动豁免相关义务。

本仓库不授予绕过账号、订阅、付费功能、访问控制或技术保护措施的权利。请仅在有权访问的账户和学校环境中进行测试；学校数据、课程材料及个人信息不因本项目的存在而可被公开、抓取或再分发。不得将证书签名通过解释为 Apple 或其他权利人对内容版权、再分发或服务使用的许可。

将上游代码、素材或包含它们的构建产物公开分享、用于商业用途或重新提交商店前，需要分别确认相应许可、平台要求及必要的权利人同意。当前仓库不提供已签名发行包，但这并不能消除仓库内第三方资源本身的授权问题。

更保守的维护方式是只公开自行编写且有权发布的适配工具、文档及不包含受保护上游内容的修改说明，由使用者自行取得合法的上游安装副本；目前仓库仍包含上游发行资源，尚未改为这种分发方式。

### 第三方服务及功能限制

本仓库不拥有或运营 BetterCampus、学校 LMS、认证、分析、日历及订阅服务，也不授予使用这些服务的额外权利。原版联网行为仍然存在，详见下文及 [CHROMEWEBSTORE.md](CHROMEWEBSTORE.md)。各服务的隐私政策、条款及访问控制独立适用；维护者不能代表其承诺账号安全、服务可用性或数据处理方式。

### 贡献与保证范围

提交贡献时，请只提供自己有权公开的代码、文档和素材，并说明引入的第三方来源及许可。不要提交从其他项目复制而无相应许可的实现、个人凭据、签名私钥、真实学生数据或未获许可的课程材料。提交贡献不会改变既有第三方内容的权利归属。

代码和记录按现状提供。维护者不承诺所有功能兼容、安全无误、持续可用或不存在第三方权利争议，也不保证某一使用或分发方式在特定司法辖区合法。这些说明不是法律意见，不排除适用法律规定且不能被排除的责任，也不将维护者自身的义务转移给使用者。

### 权利人联系与内容处理

如果你是权利人或其授权代表，认为仓库中的内容涉及未经授权使用，可通过 [仓库 Issues](https://github.com/yuanruoyu515/bettercampus-safari/issues) 提供相关文件路径、权利主张及可公开的来源说明。请勿在公开 Issue 中提交身份证件、私密授权文件或个人敏感信息。维护者将核实并视情况移除、替换相关内容或调整分发方式；此渠道不要求权利人放弃其他救济。

需要正式版权投诉时，可按 [GitHub DMCA 政策](https://docs.github.com/en/site-policy/content-removal-policies/dmca-takedown-policy) 使用其投诉渠道。删除当前分支文件不一定会消除 Git 历史、Fork 或已下载副本，必要时还需处理相应历史及平台副本，不能承诺所有副本都会消失。

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
