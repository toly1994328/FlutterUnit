/// 字体压缩包中的单个文件及完整性信息。
class RemoteFontFile {
  const RemoteFontFile(this.name, this.size, this.sha256);

  /// 压缩包根目录下的文件名。
  final String name;

  /// 未压缩文件的字节数。
  final int size;

  /// 原始文件的 SHA-256。
  final String sha256;
}

/// 固定版本的公开字体资源，不包含任何 OSS 凭据。
class RemoteFontPackage {
  const RemoteFontPackage({
    required this.family,
    required this.version,
    required this.url,
    required this.size,
    required this.sha256,
    required this.files,
  });

  /// Flutter 注册使用的字体族名称。
  final String family;

  /// 隔离本地缓存的版本号。
  final String version;

  /// OSS 返回的公开压缩包地址。
  final String url;

  /// 压缩包字节数，用于限制下载大小。
  final int size;

  /// 压缩包的 SHA-256。
  final String sha256;

  /// 允许解压和加载的完整文件清单。
  final List<RemoteFontFile> files;
}

/// 一套字体一个压缩包，保留官方原始字形和授权文件。
const RemoteFontPackage wenKaiLitePackage = RemoteFontPackage(
  family: 'LXGW WenKai Lite',
  version: '1.522',
  url: 'https://pc.toly1994.com/oss/o/obj_GVFPiZPUK7MJDdtMjWH9tVDTBTU5fown.zip',
  size: 16376985,
  sha256: 'ebcf6ce66b904dde7bdf05b993116a4bae707ea1fd3d16cf2afdc8a363055097',
  files: <RemoteFontFile>[
    RemoteFontFile('LXGWWenKaiLite-Regular.ttf', 13872424,
        '140c99ba4e28e817cec49bf82a0c5fcdc4fe633fb9dfda16d0ee8d59a8545f15'),
    RemoteFontFile('LXGWWenKaiLite-Medium.ttf', 13700636,
        '02eb0f8deed11b00481393f5720630ae1a44424f37f4157ea160a69a1c72a0b6'),
    RemoteFontFile('OFL.txt', 4448,
        'c38b1994a5e48ac30ac7d1da7d0409fd8fd8127dfe28a13d6e787d5b1ef34a5e'),
  ],
);
