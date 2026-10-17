import 'dart:convert';
import 'dart:io' as io;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';

/// 使用临时目录保存真实缓存文件，不依赖测试机器的平台插件。
class DiskImageFiles implements FileSystem {
  /// 每次测试独立的文件目录。
  final io.Directory directory;
  DiskImageFiles(this.directory);
  @override
  Future<file.File> createFile(String name) async =>
      const LocalFileSystem().file('${directory.path}/$name');
}

/// 记录下载次数，断网后仍需从磁盘读取已有图片。
class ImageFileService extends FileService {
  /// 下载请求总数。
  int requests = 0;

  /// 模拟断网，禁止测试悄悄再次下载相同资源。
  bool offline = false;
  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String>? headers}) async {
    requests++;
    if (offline) throw const io.SocketException('模拟断网');
    return ImageFileResponse();
  }
}

class ImageFileResponse implements FileServiceResponse {
  /// 动图编码原始数据，缓存不得转成其他格式。
  static final List<int> bytes =
      base64Decode('R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7');
  @override
  Stream<List<int>> get content => Stream<List<int>>.value(bytes);
  @override
  int get contentLength => bytes.length;
  @override
  int get statusCode => 200;
  @override
  DateTime get validTill => DateTime.now().add(const Duration(days: 1));
  @override
  String get eTag => 'reading-image-test';
  @override
  String get fileExtension => '.gif';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('插件缓存落盘后重建管理器仍可断网读取，尺寸参数区分缓存', testDiskCache);
}

Future<void> testDiskCache() async {
  final io.Directory directory =
      await io.Directory.systemTemp.createTemp('flutterunit-image-cache-');
  final ImageFileService service = ImageFileService();
  CacheManager manager() => CacheManager(Config('reading-image-test',
      repo: JsonCacheInfoRepository(path: '${directory.path}/cache.json'),
      fileSystem: DiskImageFiles(directory),
      fileService: service));
  final CacheManager first = manager();
  CacheManager? reopened;
  const String source =
      'https://pc.toly1994.com/oss/o/photo.png?w=448&format=png';
  try {
    final CachedNetworkImageProvider provider =
        CachedNetworkImageProvider(source, cacheManager: first);
    final file.File saved =
        await provider.cacheManager!.getSingleFile(provider.url);
    expect(await saved.exists(), isTrue);
    expect(await saved.readAsBytes(), orderedEquals(ImageFileResponse.bytes));
    expect(service.requests, 1);
    await first.dispose();
    service.offline = true;
    reopened = manager();
    final file.File cached = await reopened.getSingleFile(source);
    expect(await cached.readAsBytes(), orderedEquals(ImageFileResponse.bytes));
    expect(service.requests, 1);
    await expectLater(reopened.getSingleFile(source.replaceFirst('448', '832')),
        throwsA(isA<io.SocketException>()));
    expect(service.requests, 2);
  } finally {
    if (reopened != null) await reopened.dispose();
    // 只清理本测试刚创建的独立临时目录。
    expect(directory.parent.path, io.Directory.systemTemp.path);
    expect(directory.path.split(io.Platform.pathSeparator).last,
        startsWith('flutterunit-image-cache-'));
    await directory.delete(recursive: true);
  }
}
