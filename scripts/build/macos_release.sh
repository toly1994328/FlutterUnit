#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RELEASE_ENV="${FLUTTER_UNIT_RELEASE_ENV_PATH:-$PROJECT_ROOT/../.fx/.env/.client.release}"
ENTITLEMENTS="$PROJECT_ROOT/macos/Runner/DeveloperId.entitlements"
DMG_BACKGROUND="$PROJECT_ROOT/macos/installer/background.png"
OUTPUT_DIR="$PROJECT_ROOT/build/distribution/macos"
SYMBOLS_ROOT="$PROJECT_ROOT/build/macos-symbols"

info() {
  printf '\033[34m[INFO]\033[0m %s\n' "$1"
}

success() {
  printf '\033[32m[ OK ]\033[0m %s\n' "$1"
}

fail() {
  printf '\033[31m[FAIL]\033[0m %s\n' "$1" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "缺少命令：$1"
}

require_file() {
  [[ -f "$1" ]] || fail "缺少文件：$1"
}

require_environment() {
  [[ -n "${!1:-}" ]] || fail "缺少环境变量：$1"
}

read_version() {
  local version_line
  version_line="$(sed -nE 's/^version:[[:space:]]*([^[:space:]]+).*/\1/p' "$PROJECT_ROOT/pubspec.yaml" | head -n 1)"
  [[ -n "$version_line" ]] || fail "pubspec.yaml 缺少 version"
  [[ "$version_line" == *+* ]] || fail "pubspec.yaml 的 version 必须包含 Build Number"
  printf '%s' "$version_line"
}

find_built_app() {
  local release_directory
  local app_count
  release_directory="$PROJECT_ROOT/build/macos/Build/Products/Release"
  app_count="$(find "$release_directory" -maxdepth 1 -type d -name '*.app' | wc -l | tr -d ' ')"
  [[ "$app_count" == "1" ]] || fail "期望生成一个 macOS App，实际找到 $app_count 个"
  find "$release_directory" -maxdepth 1 -type d -name '*.app' -print -quit
}

build_app() {
  local version
  local symbols_directory
  version="$1"
  symbols_directory="$SYMBOLS_ROOT/$version"

  info "清理 Flutter 构建缓存"
  flutter clean
  info "获取 Flutter 依赖"
  flutter pub get
  info "生成 macOS Release 配置"
  flutter build macos \
    --release \
    --config-only \
    --obfuscate \
    --split-debug-info="$symbols_directory" \
    --dart-define-from-file="$RELEASE_ENV"

  info "构建 macOS universal App"
  xcodebuild \
    -workspace macos/Runner.xcworkspace \
    -scheme Runner \
    -configuration Release \
    -derivedDataPath build/macos \
    -destination 'platform=macOS' \
    -quiet \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGNING_REQUIRED=NO \
    ONLY_ACTIVE_ARCH=NO \
    'ARCHS=arm64 x86_64' \
    build
}

sign_app() {
  local app_path
  local framework_path
  local dynamic_library
  app_path="$1"

  while IFS= read -r framework_path; do
    codesign \
      --force \
      --options runtime \
      --timestamp \
      --sign "$DEVELOPER_ID_SIGN_IDENTITY" \
      "$framework_path"
  done < <(find "$app_path/Contents/Frameworks" -maxdepth 1 -type d -name '*.framework' | sort)

  while IFS= read -r dynamic_library; do
    codesign \
      --force \
      --options runtime \
      --timestamp \
      --sign "$DEVELOPER_ID_SIGN_IDENTITY" \
      "$dynamic_library"
  done < <(find "$app_path/Contents/Frameworks" -maxdepth 1 -type f -name '*.dylib' | sort)

  codesign \
    --force \
    --deep \
    --options runtime \
    --timestamp \
    --entitlements "$ENTITLEMENTS" \
    --sign "$DEVELOPER_ID_SIGN_IDENTITY" \
    "$app_path"
  codesign --verify --deep --strict --verbose=2 "$app_path"
}

verify_universal_binary() {
  local app_path
  local executable_name
  local executable_path
  local architectures
  app_path="$1"
  executable_name="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$app_path/Contents/Info.plist")"
  executable_path="$app_path/Contents/MacOS/$executable_name"
  architectures="$(lipo -archs "$executable_path")"
  [[ "$architectures" == *arm64* ]] || fail "App 缺少 arm64 架构：$architectures"
  [[ "$architectures" == *x86_64* ]] || fail "App 缺少 x86_64 架构：$architectures"
  info "App 架构：$architectures"
}

create_dmg() {
  local app_path
  local version
  local dmg_path
  local staging_directory
  app_path="$1"
  version="$2"
  dmg_path="$OUTPUT_DIR/FlutterUnit-$version.dmg"
  staging_directory="$(mktemp -d "${TMPDIR:-/tmp}/flutter-unit-dmg.XXXXXX")"

  rm -f "$dmg_path"
  ditto "$app_path" "$staging_directory/$(basename "$app_path")"
  create-dmg \
    --volname FlutterUnit \
    --background "$DMG_BACKGROUND" \
    --window-pos 360 100 \
    --window-size 800 600 \
    --icon-size 80 \
    --icon "$(basename "$app_path")" 230 285 \
    --app-drop-link 570 285 \
    --no-internet-enable \
    "$dmg_path" \
    "$staging_directory"
  codesign \
    --force \
    --timestamp \
    --sign "$DEVELOPER_ID_SIGN_IDENTITY" \
    "$dmg_path"
  codesign --verify --verbose=2 "$dmg_path"
  rm -rf "$staging_directory"
}

notarize_dmg() {
  local dmg_path
  dmg_path="$1"
  xcrun notarytool submit "$dmg_path" \
    --apple-id "$APPLE_ID" \
    --team-id "$TEAM_ID" \
    --password "$APP_SPECIFIC_PASSWORD" \
    --wait
  xcrun stapler staple "$dmg_path"
  xcrun stapler validate "$dmg_path"
  spctl \
    --assess \
    --type open \
    --context context:primary-signature \
    --verbose \
    "$dmg_path"
}

main() {
  local version
  local app_path
  local dmg_path

  require_command flutter
  require_command xcodebuild
  require_command codesign
  require_command create-dmg
  require_file "$RELEASE_ENV"
  require_file "$ENTITLEMENTS"
  require_file "$DMG_BACKGROUND"
  require_environment DEVELOPER_ID_SIGN_IDENTITY
  require_environment APPLE_ID
  require_environment TEAM_ID
  require_environment APP_SPECIFIC_PASSWORD

  cd "$PROJECT_ROOT"
  version="$(read_version)"
  mkdir -p "$OUTPUT_DIR" "$SYMBOLS_ROOT/$version"
  build_app "$version"
  app_path="$(find_built_app)"
  verify_universal_binary "$app_path"
  sign_app "$app_path"
  dmg_path="$OUTPUT_DIR/FlutterUnit-$version.dmg"
  create_dmg "$app_path" "$version"
  notarize_dmg "$dmg_path"
  success "macOS 签名与公证构建完成：$dmg_path"
  shasum -a 256 "$dmg_path"
}

main "$@"
