# BetterCampus Safari

**English** | [简体中文](README.zh-CN.md)

An unofficial Safari port of BetterCampus with compatibility fixes, maintained for further development and personal builds. Based on Chrome release **9.8.15**; current port version: **9.8.15.1**.

The original extension provides themes, course grades, and assignment tools for Canvas LMS. This repository retains upstream distribution assets and fixes Canvas JSON handling, batched GraphQL queries, and extension messaging in Safari. It is not an official BetterCampus project or the complete upstream development source; most application logic comes from bundled JavaScript.

> **Copyright and authorization status:** This repository contains third-party distribution code and assets. Express upstream authorization for this public redistribution has not been confirmed. Public availability, attribution, personal use, or noncommercial research does not itself grant permission to copy, modify, or redistribute, nor does it automatically establish fair use. The notices below cannot supply missing authorization or guarantee freedom from infringement claims. Verify the relevant rights and applicable terms before using, modifying, or distributing the contents.

## Copyright, trademarks, and use

### Unofficial project

This project is independently maintained for Safari compatibility research and personal maintenance. No affiliation, partnership, sponsorship, certification, or endorsement by BetterCampus, Apple, Google, Instructure, any school, or other named service provider has been established by this repository. Do not treat it as an official release, support channel, or service commitment from those parties.

BetterCampus, BetterCanvas, Safari, Chrome, Canvas, and related names and marks belong to their respective owners. Names are used to identify sources, compatibility targets, and operating steps; this does not imply a trademark license. Retained upstream icons and branding likewise receive no new license through this repository. Do not use them to impersonate an official project, mislead users, or imply endorsement.

### Rights in third-party code and assets

Rights in upstream JavaScript, styles, images, videos, fonts, translations, and other assets remain with their respective owners. The maintainer describes the adaptation work in this repository and does not claim ownership of those third-party materials. See [SOURCE.json](SOURCE.json), [THIRD_PARTY.md](THIRD_PARTY.md), and [PORTING_NOTES.md](PORTING_NOTES.md) for provenance, versions, file hashes, and modification scope. The supporting prose documents are currently in Chinese.

This repository does not relicense upstream material under MIT, Apache, or another open-source license, and does not provide a single open-source license covering the entire repository. A component's license applies only to the material it explicitly covers. For example, the font directory's [OFL.txt](safari-extension/fonts/OFL.txt) is not a license for the entire extension. Preserve existing copyright notices, license texts, and attribution.

Being able to install an extension from the Chrome Web Store, inspect its distribution code, or view or fork a GitHub repository does not grant unrestricted rights to modify, distribute, sell, republish, or use trademarks. See [GitHub's licensing guidance](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository) for the distinction between platform features and content licensing. Those features also do not establish that the uploader has obtained third-party permission.

### Use and redistribution boundaries

The stated purpose describes maintenance goals; it is not a license to third-party content. Both users and maintainers must comply with applicable law, existing licenses, and applicable terms of software stores, Apple developer services, schools, and third-party services. Personal use, noncommercial use, or an “educational purposes only” notice does not automatically waive those obligations.

This repository grants no right to bypass accounts, subscriptions, paid features, access controls, or technological protection measures. Test only with accounts and school environments you are authorized to access. The existence of this project does not authorize publishing, scraping, or redistributing school data, course materials, or personal information. Successful code signing must not be interpreted as permission from Apple or another rights holder regarding content copyright, redistribution, or service access.

Before publicly sharing upstream code, assets, or builds containing them, using them commercially, or resubmitting them to a store, separately verify the relevant licenses, platform requirements, and any necessary rights-holder consent. This repository does not provide signed release packages, but that does not resolve authorization issues concerning the third-party assets it contains.

A more conservative maintenance approach is to publish only adaptation tools and documentation that the author has the right to release, plus change descriptions that do not contain protected upstream material, with users obtaining their own lawful upstream installation copies. This repository still includes upstream distribution assets and has not been converted to that distribution model.

### Third-party services and feature limits

This repository does not own or operate BetterCampus, school LMS, authentication, analytics, calendar, or subscription services, and grants no additional rights to use them. Original network behavior remains; see below and [CHROMEWEBSTORE.md](CHROMEWEBSTORE.md). Each service's privacy policy, terms, and access controls apply independently. The maintainer cannot promise account security, service availability, or data handling on their behalf.

### Contributions and warranty limits

Contribute only code, documentation, and assets you have the right to publish, and identify any introduced third-party sources and licenses. Do not submit implementations copied without the required permission, personal credentials, signing private keys, real student data, or unauthorized course materials. Contributions do not change ownership of existing third-party content.

Code and records are provided as is. The maintainer does not promise complete compatibility, security, uninterrupted availability, or freedom from third-party rights disputes, and does not guarantee that a particular use or distribution is lawful in any jurisdiction. These notices are not legal advice, do not exclude liability that applicable law does not permit to be excluded, and do not transfer the maintainer's own obligations to users.

### Rights-holder contact and content handling

If you are a rights holder or authorized representative and believe repository content is being used without permission, you may open a [repository issue](https://github.com/yuanruoyu515/bettercampus-safari/issues) identifying the relevant file paths, rights claim, and source information suitable for public disclosure. Do not post identity documents, confidential authorization records, or sensitive personal information in a public issue. The maintainer will review the matter and, as appropriate, remove or replace content or adjust distribution. Using this channel does not require waiving other remedies.

For a formal copyright complaint, use the channels described in [GitHub's DMCA policy](https://docs.github.com/en/site-policy/content-removal-policies/dmca-takedown-policy). Deleting files from the current branch may not remove Git history, forks, or downloaded copies. Relevant history and platform copies may require separate handling; removal of every copy cannot be promised.

## Implemented fixes

- Safari Manifest V3 adaptation, retaining content scripts, images, fonts, and translations.
- Grade GraphQL queries limited to five items per batch, merged by alias to avoid the server's query-alias limit.
- Validation of the current school origin, HTTP status, and JSON content, including Canvas JSON prefixes; bounded retries for reads and no automatic retries for writes.
- Safari document-messaging compatibility with precise document and page-origin validation retained.
- Account sync skipped when signed out; at most one token refresh and retry after a 401 response.
- A macOS Xcode host project. On macOS 27.0.1 / Safari 27.0.1, the maintainer used Apple Development signing with a free Apple ID and verified that the extension remained enabled after turning off “Allow Unsigned Extensions,” fully quitting Safari, and restarting it.

## Build and sign

Requirements: a Mac, full Xcode, and Python 3. Open Xcode, complete initial setup, and sign in with your own Apple ID under Settings → Apple Accounts.

```sh
git clone https://github.com/yuanruoyu515/bettercampus-safari.git
cd bettercampus-safari
python3 scripts/prepare.py
```

Open `AppleSignedXcode/BetterCampus Safari.xcodeproj` and select your own Team for both the app and extension targets. Build in Xcode, or pass your Team ID to the script:

```sh
TEAM_ID=YOUR_TEAM_ID ./scripts/build.sh
```

Xcode may need to create an Apple Development certificate. Complete system authentication and any account terms yourself. The script does not export private keys, automatically install the app, or change Safari security settings.

Built app: `Build/Build/Products/Release/BetterCampus Safari.app`. Place it in a permanent Applications folder, open it once, enable the extension in Safari's extension settings, and grant website access as needed. Keep the app installed; you do not need to launch the host app each time.

Free development signing is for personal development and testing, not general distribution. Before the certificate expires, rebuild, sign, and replace the app. Check your own certificate and any generated provisioning profile's expiration; do not assume every environment matches the maintainer's test. Signed installation packages are not included in this repository. Use your own signing account.

To check local compilation without a signing account:

```sh
./scripts/build.sh --unsigned
```

An unsigned build does not replace the Apple-signed installation process above.

## Modify and check

**Edit extension assets only in `safari-extension/`**, rather than the generated Resources folder under Xcode. `scripts/prepare.py` and the build script recopy those assets, changing only the installed version's display name to `BetterCampus (Safari Installed)`.

```sh
node tests/regression.cjs
```

Run the existing regression checks with Node.js 22 or later. Tests use synthetic data and do not access real schools or accounts. After changing messaging, JSON handling, or grade queries, run the checks, rebuild, and validate in a school environment you are authorized to use.

| Path | Purpose |
| --- | --- |
| `safari-extension/` | Single maintained source for extension assets |
| `AppleSignedXcode/` | macOS project generated from Apple's template, with corrected identifiers |
| `scripts/` | Resource preparation, Apple signing, and unsigned compilation |
| `tests/regression.cjs` | Regression checks for responses, batched grades, message identity, and sync |
| `native/` | Earlier ad-hoc host app built with Command Line Tools, retained as a fallback |
| `PORTING_NOTES.md` | Specific adaptations and known limits (Chinese) |
| `VALIDATION.md` | Completed validation and its limits (Chinese) |
| `SOURCE.json` | Upstream version, file hashes, and modification scope |
| `CHROMEWEBSTORE.md` | Upstream permissions and data-use record, not a store submission (Chinese) |

The earlier ad-hoc build still depends on Safari's unsigned-extension setting. Direct folder loading is subject to Safari's temporary-extension limits. Prefer the Xcode signing process above for regular use.

## Accounts, data, and updates

No browser cookies, login tokens, extension storage, or school data were copied. Sign in to Safari websites and BetterCampus separately as needed; theme restoration depends on the upstream account service.

Original BetterCampus, Supabase, PostHog, and feature-specific school and calendar requests remain. Account, subscription, and paid-feature checks are not bypassed. Safari website permissions remain under the user's control.

Chrome upstream updates are not merged automatically. When updating bundled upstream files, review and reapply this repository's compatibility fixes, run the regression checks, and validate in Safari.

## Sources

The original work and assets belong to BetterCampus and their respective rights holders; see [THIRD_PARTY.md](THIRD_PARTY.md). This repository does not add a new open-source license to upstream code or imply official support or relicensing permission.

- [BetterCampus](https://bettercampus.com/)
- [Original Chrome Web Store extension](https://chromewebstore.google.com/detail/cndibmoanboadcifjkjbdpjgfedanolh)
- [Apple: Running your Safari web extension](https://developer.apple.com/documentation/safariservices/running-your-safari-web-extension)
- [Apple: Distributing your Safari web extension](https://developer.apple.com/documentation/safariservices/distributing-your-safari-web-extension)
- [PortKit's free development signing notes](https://github.com/Vatsal057/chrome-to-safari#before-you-start-a-free-signing-certificate): a reference for the signing approach; its conversion script was neither executed nor copied.
