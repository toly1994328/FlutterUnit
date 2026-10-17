# Windows 在线字体

Windows 首次升级自动选择霞鹜文楷轻便版，后台从 OSS 下载，校验并注册到 Flutter；完成后立即刷新主题。用户后续可以在字体设置中切换其他字体。其他平台不启动下载。

- Bucket：`assets`
- Object Key：`fonts/LXGWWenKaiLite-v1.522.zip`
- 公开链接：https://pc.toly1994.com/oss/o/obj_GVFPiZPUK7MJDdtMjWH9tVDTBTU5fown.zip
- ZIP：16,376,985 字节，SHA-256 `ebcf6ce66b904dde7bdf05b993116a4bae707ea1fd3d16cf2afdc8a363055097`
- 来源：https://github.com/lxgw/LxgwWenKai-Lite/releases/tag/v1.522

一套字体一个 ZIP，根目录包含未修改的 `LXGWWenKaiLite-Regular.ttf`、`LXGWWenKaiLite-Medium.ttf`、`OFL.txt`。压缩仅用于传输，不裁剪或更改原始字体。解压后共约 27.6 MB，不计入应用安装包。

本地缓存位于 `getApplicationSupportDirectory()/fonts/lxgw-wenkai-lite/1.522/`。每次启动校验文件，缓存有效时不访问网络；缓存损坏时重新下载。下载或解压失败时使用 Windows 中文系统字体，并可从字体设置页重试。

## 维护入口

- `modules/basic_system/app/lib/app/typography/remote_font_package.dart`：字体版本、公开 URL、包及文件的大小和哈希。
- `remote_font_store.dart`：下载、ZIP 校验、按清单解压、文件缓存校验。
- `windows_font_controller.dart`：运行时注册、状态通知、许可证登记。
- `lib/src/starter/start_repository.dart`：一次性迁移默认字体，保留原有字体索引。
- `lib/src/flutter_unit.dart`：非阻塞加载和主题刷新。

更新字体时使用新版本文件名和缓存目录，不覆盖旧版本对象，并更新包描述中的哈希。客户端只访问公开下载地址，不包含 OSS 上传凭据或管理令牌。

字体许可为 SIL OFL 1.1，原始授权随 ZIP 和本地缓存保留，并登记到 Flutter 的应用许可证列表。字体文件没有作为系统字体安装，也不需要管理员权限。Markdown 正文沿用 Windows 应用字体，代码块继续使用等宽字体。
