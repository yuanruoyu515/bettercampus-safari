#!/usr/bin/env python3
"""Build a macOS carrier app using Apple's installed Command Line Tools.

This local build is ad-hoc signed, not Apple Developer signed or notarized.
It never installs an app or changes Safari/security settings.
"""
import json
import plistlib
import shutil
import subprocess
from pathlib import Path

project = Path(__file__).resolve().parents[1]
output = project / 'Build' / 'adhoc' / 'BetterCampus Safari.app'
cache = project / 'Build' / 'native-module-cache'
cache.mkdir(parents=True, exist_ok=True)
if output.exists():
    raise SystemExit(f'Refusing to overwrite an existing app: {output}')

app_id = 'local.bettercampus.safariport'
extension_id = app_id + '.Extension'
contents = output / 'Contents'
extension = contents / 'PlugIns' / 'BetterCampus Extension.appex'
resources = extension / 'Contents' / 'Resources'
for path in [contents / 'MacOS', contents / 'Resources', extension / 'Contents' / 'MacOS']:
    path.mkdir(parents=True)
shutil.copytree(project / 'safari-extension', resources)
manifest = json.loads((resources / 'manifest.json').read_text())
manifest['name'] = 'BetterCampus (Safari Installed)'
(resources / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')

def plist(path, data):
    path.write_bytes(plistlib.dumps(data, sort_keys=False))

common = {
    'CFBundleDevelopmentRegion': 'en', 'CFBundleInfoDictionaryVersion': '6.0',
    'CFBundleShortVersionString': '9.8.15.1', 'CFBundleVersion': '981501',
    'LSMinimumSystemVersion': '15.4',
}
plist(contents / 'Info.plist', {**common,
    'CFBundleIdentifier': app_id, 'CFBundleExecutable': 'BetterCampusSafari',
    'CFBundleName': 'BetterCampus Safari', 'CFBundleDisplayName': 'BetterCampus Safari',
    'CFBundlePackageType': 'APPL', 'NSPrincipalClass': 'NSApplication',
    'NSHighResolutionCapable': True,
})
plist(extension / 'Contents' / 'Info.plist', {**common,
    'CFBundleIdentifier': extension_id, 'CFBundleExecutable': 'BetterCampusExtension',
    'CFBundleName': 'BetterCampus Extension', 'CFBundleDisplayName': 'BetterCampus (本机安装版)',
    'CFBundlePackageType': 'XPC!',
    'NSHumanReadableDescription': 'BetterCampus 的本机 Safari 移植版。',
    'NSExtension': {'NSExtensionPointIdentifier': 'com.apple.Safari.web-extension',
                    'NSExtensionPrincipalClass': 'SafariWebExtensionHandler'},
})
sdk = subprocess.check_output(['/usr/bin/xcrun', '--show-sdk-path'], text=True).strip()
compiler = ['/usr/bin/xcrun', 'clang', '-fobjc-arc', '-fmodules',
            '-fmodules-cache-path=' + str(cache), '-isysroot', sdk,
            '-mmacosx-version-min=15.4', '-arch', 'arm64']
subprocess.run(compiler + ['-framework', 'Cocoa', '-framework', 'SafariServices',
    str(project / 'native' / 'Host.m'), '-o', str(contents / 'MacOS' / 'BetterCampusSafari')], check=True)
subprocess.run(compiler + ['-fapplication-extension', '-framework', 'Foundation',
    '-Wl,-e,_NSExtensionMain', str(project / 'native' / 'Extension.m'),
    '-o', str(extension / 'Contents' / 'MacOS' / 'BetterCampusExtension')], check=True)

host_entitlements = cache / 'host-entitlements.plist'
extension_entitlements = cache / 'extension-entitlements.plist'
plist(host_entitlements, {'com.apple.security.app-sandbox': True})
plist(extension_entitlements, {'com.apple.security.app-sandbox': True,
                               'com.apple.security.network.client': True})
for path, entitlements in [(extension, extension_entitlements), (output, host_entitlements)]:
    subprocess.run(['/usr/bin/codesign', '--force', '--sign', '-', '--timestamp=none',
        '--entitlements', str(entitlements), str(path)], check=True)
subprocess.run(['/usr/bin/codesign', '--verify', '--deep', '--strict', '--verbose=2', str(output)], check=True)
print(output)
