import 'package:flutter/material.dart';

import '../icon_font_gen/icon_font_gen_page.dart';
import '../jwt_debugger/view.dart';
import '../view/json_display/json_display.dart';
import '../view/text_codec/text_codec_tool.dart';

/// 工具在目录中的业务分类。
enum ToolCategory {
  dataFormat('格式转换', Icons.data_object_rounded),
  codec('编解码', Icons.swap_horiz_rounded),
  generator('生成器', Icons.auto_awesome_outlined);

  /// 分类显示名称。
  final String label;

  /// 分类图标。
  final IconData icon;

  const ToolCategory(this.label, this.icon);
}

/// 桌面工具箱当前提供的工具目录。
enum DeveloperTool {
  jsonParser(
    id: 'json-parser',
    label: 'JSON 解析',
    description: '格式化、压缩并浏览 JSON 数据树',
    icon: Icons.data_object_rounded,
    category: ToolCategory.dataFormat,
  ),
  base64Codec(
    id: 'base64-codec',
    label: 'Base64 编解码',
    description: '在文本与 Base64 之间相互转换',
    icon: Icons.code_rounded,
    category: ToolCategory.codec,
  ),
  urlCodec(
    id: 'url-codec',
    label: 'URL 编解码',
    description: '处理 URL 组件的百分号编码',
    icon: Icons.link_rounded,
    category: ToolCategory.codec,
  ),
  jwtDebugger(
    id: 'jwt-debugger',
    label: 'JWT 调试器',
    description: '解析 Header、Payload 和时间声明',
    icon: Icons.shield_outlined,
    category: ToolCategory.codec,
  ),
  iconFont(
    id: 'icon-font',
    label: 'IconFont',
    description: '从 IconFont 压缩包生成 Flutter 资源',
    icon: Icons.font_download_outlined,
    category: ToolCategory.generator,
  );

  /// 稳定工具标识。
  final String id;

  /// 工具显示名称。
  final String label;

  /// 工具用途摘要。
  final String description;

  /// 工具图标。
  final IconData icon;

  /// 所属目录分类。
  final ToolCategory category;

  const DeveloperTool({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.category,
  });

  /// 创建工具对应的工作区视图。
  Widget buildView() {
    return switch (this) {
      DeveloperTool.jsonParser => const JsonAnalysisTool(),
      DeveloperTool.base64Codec => const Base64CodecTool(),
      DeveloperTool.urlCodec => const UrlCodecTool(),
      DeveloperTool.jwtDebugger => const JwtDebuggerTool(),
      DeveloperTool.iconFont => const IconFontGenPage(),
    };
  }
}
