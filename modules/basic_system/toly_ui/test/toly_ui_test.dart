import 'package:flutter_test/flutter_test.dart';

import 'package:toly_ui/toly_ui.dart';

void main() {
  test('自动识别 HTTP 图片', () {
    const ImageRender render = ImageRender(source: 'https://example.com/a.png');
    expect(
        render.resolveSourceType(render.source), ImageRenderSourceType.network);
  });

  test('自动识别 Flutter 资产图片', () {
    const ImageRender render = ImageRender(source: 'assets/images/a.png');
    expect(
        render.resolveSourceType(render.source), ImageRenderSourceType.asset);
  });

  test('自动识别本机文件图片', () {
    const ImageRender render = ImageRender(source: '/tmp/a.png');
    expect(render.resolveSourceType(render.source), ImageRenderSourceType.file);
  });

  test('自动识别 Windows 本机文件图片', () {
    const ImageRender render = ImageRender(source: r'C:\images\a.png');
    expect(render.resolveSourceType(render.source), ImageRenderSourceType.file);
  });

  test('显式资源类型优先于自动识别', () {
    const ImageRender render = ImageRender(
      source: '/uploads/original/a.png',
      sourceType: ImageRenderSourceType.network,
    );
    expect(
        render.resolveSourceType(render.source), ImageRenderSourceType.network);
  });
}
