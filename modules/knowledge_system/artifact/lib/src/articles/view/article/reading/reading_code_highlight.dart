import 'package:flutter/painting.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:re_highlight/styles/atom-one-dark.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/languages/typescript.dart';
import 'package:re_highlight/languages/javascript.dart';
import 'package:re_highlight/languages/json.dart';
import 'package:re_highlight/languages/yaml.dart';
import 'package:re_highlight/languages/bash.dart';
import 'package:re_highlight/languages/powershell.dart';
import 'package:re_highlight/languages/java.dart';
import 'package:re_highlight/languages/kotlin.dart';
import 'package:re_highlight/languages/swift.dart';
import 'package:re_highlight/languages/python.dart';
import 'package:re_highlight/languages/rust.dart';
import 'package:re_highlight/languages/c.dart';
import 'package:re_highlight/languages/cpp.dart';
import 'package:re_highlight/languages/csharp.dart';
import 'package:re_highlight/languages/sql.dart';
import 'package:re_highlight/languages/xml.dart';
import 'package:re_highlight/languages/css.dart';
import 'package:re_highlight/languages/glsl.dart';
import 'package:re_highlight/languages/ini.dart';
import 'package:re_highlight/languages/cmake.dart';
import 'package:re_highlight/languages/diff.dart';
import 'package:re_highlight/languages/http.dart';

/// 高亮结果与语言标记一起缓存，字号变化时不用再次分析源码。
class ReadingCodeHighlight {
  /// 仅含文字与颜色的高亮片段，可选择、复制。
  final TextSpan span;

  /// 明确声明或可靠识别出的语言，无法识别时为 text。
  final String language;
  const ReadingCodeHighlight(this.span, this.language);
}

/// 只注册文库常见语言，避免引入全部语法的解析开销。
final Highlight _engine = _createEngine();
Highlight _createEngine() => Highlight()
  ..registerLanguages(<String, Mode>{
    'dart': langDart,
    'typescript': langTypescript,
    'javascript': langJavascript,
    'json': langJson,
    'yaml': langYaml,
    'bash': langBash,
    'powershell': langPowershell,
    'java': langJava,
    'kotlin': langKotlin,
    'swift': langSwift,
    'python': langPython,
    'rust': langRust,
    'c': langC,
    'cpp': langCpp,
    'csharp': langCsharp,
    'sql': langSql,
    'xml': langXml,
    'css': langCss,
    'glsl': langGlsl,
    'ini': langIni,
    'cmake': langCmake,
    'diff': langDiff,
    'http': langHttp,
  });

/// 语言别名统一后交给语法解析器，未标语言仅在有限候选中识别。
ReadingCodeHighlight highlightReadingCode(String source, String language) {
  final String display = source.replaceFirst(RegExp(r'\r?\n$'), '');
  final String requested = language.trim().toLowerCase();
  String resolved = const <String, String>{
        'ts': 'typescript',
        'js': 'javascript',
        'sh': 'bash',
        'shell': 'bash',
        'ps1': 'powershell',
        'pwsh': 'powershell',
        'py': 'python',
        'rs': 'rust',
        'kt': 'kotlin',
        'c++': 'cpp',
        'c#': 'csharp',
        'cs': 'csharp',
        'svg': 'xml',
        'html': 'xml',
        'yml': 'yaml',
        'toml': 'ini',
        'txt': 'text',
        'plaintext': 'text',
        'plain': 'text',
      }[requested] ??
      requested;
  ReadingCodeHighlight plain() => ReadingCodeHighlight(
      TextSpan(text: display), resolved.isEmpty ? 'text' : resolved);
  if (display.trim().isEmpty || display.length > 100000) return plain();
  try {
    HighlightResult result;
    if (resolved.isEmpty) {
      if (display.length > 16000) return plain();
      if (RegExp(
              r'\b(?:Widget|BuildContext|StatelessWidget|StatefulWidget)\b|@override|import [\x27\x22](?:package:|dart:)')
          .hasMatch(display)) {
        resolved = 'dart';
        result = _engine.highlight(code: display, language: resolved);
      } else {
        result = _engine.highlightAuto(display, <String>[
          'dart',
          'json',
          'typescript',
          'javascript',
          'python',
          'bash',
        ]);
        if (result.language == null || result.relevance < 2) return plain();
        resolved = result.language!;
      }
    } else {
      if (_engine.getLanguage(resolved) == null) return plain();
      result = _engine.highlight(code: display, language: resolved);
    }
    final TextSpanRenderer renderer = TextSpanRenderer(
        const TextStyle(color: Color(0xffABB2BF)), atomOneDarkTheme);
    result.render(renderer);
    final TextSpan? span = renderer.span;
    // 语法识别不能改变字符、缩进或换行，异常时安全回退原文。
    if (span == null || span.toPlainText() != display) return plain();
    return ReadingCodeHighlight(span, resolved);
  } catch (_) {
    return plain();
  }
}
