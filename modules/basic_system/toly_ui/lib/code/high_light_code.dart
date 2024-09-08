/// create by 张风捷特烈 on 2020-04-15
/// contact me by email 1981462002@qq.com
/// 说明:

// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:string_scanner/string_scanner.dart';

import 'highlighter_style.dart';
import 'language/dart_languge.dart';
import 'language/language.dart';

/// final SyntaxHighlighterStyle style = SyntaxHighlighterStyle.lightThemeStyle();
/// DartSyntaxHighlighter(style).format(source)

abstract class Highlighter {
  // ignore: one_member_abstracts
  ProgramLanguage language;


  Highlighter({required this.language});

  TextSpan format(String src);
}

//暗黑模式下的高亮样式
class CodeHighlighter extends Highlighter {
  CodeHighlighter(
      {ProgramLanguage language = const DartLanguage(), HighlighterStyle? style}):super(language: language) {
    _spans = <_HighlightSpan>[];
    _style = style ?? HighlighterStyle.fromColors(HighlighterStyle.lightColor);
  }

 late HighlighterStyle _style;

  String _src='';
  late StringScanner _scanner;

  List<_HighlightSpan> _spans=[];

  @override
  TextSpan format(String src) {
    _src = src;
    _scanner = StringScanner(_src);

    if (_generateSpans()) {
      // Successfully parsed the code
      final List<TextSpan> formattedText = <TextSpan>[];
      int currentPosition = 0;

      for (_HighlightSpan span in _spans) {
        if (currentPosition != span.start) {
          formattedText
              .add(TextSpan(text: _src.substring(currentPosition, span.start)));
        }

        formattedText.add(TextSpan(
            style: span.textStyle(_style), text: span.textForSpan(_src)));

        currentPosition = span.end;
      }

      if (currentPosition != _src.length) {
        formattedText
            .add(TextSpan(text: _src.substring(currentPosition, _src.length)));
      }

      return TextSpan(style: _style.baseStyle, children: formattedText);
    } else {
      // Parsing failed, return with only basic formatting
      return TextSpan(style: _style.baseStyle, text: src);
    }
  }

  bool _generateSpans() {
    int lastLoopPosition = _scanner.position;

    while (!_scanner.isDone) {
      // Skip White space
      _scanner.scan(RegExp(r'\s+'));

      // Block comments
      if (_scanner.scan(RegExp(r'/\*(.|\n)*\*/'))) {
        _spans.add(_HighlightSpan(_HighlightType.comment,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Line comments
      if (_scanner.scan(RegExp(r'//'))) {
        final int startComment = _scanner.lastMatch?.start??0;
        bool eof = false;
        int endComment;
        if (_scanner.scan(RegExp(r'(.*\r\n)|(.*\n)'))) {
          int? end = _scanner.lastMatch?.end;
          endComment = end==null?0:end - 1;
        } else {
          eof = true;
          endComment = _src.length;
        }

        _spans.add(_HighlightSpan(_HighlightType.comment, startComment, endComment));

        if (eof) break;
        continue;
      }

      // Raw r"String"
      if (_scanner.scan(RegExp(r'r".*"'))) {
        _spans.add(_HighlightSpan(_HighlightType.string,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Raw r'String'
      if (_scanner.scan(RegExp(r"r'.*'"))) {
        _spans.add(_HighlightSpan(_HighlightType.string,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Multiline """String"""
      if (_scanner.scan(RegExp(r'"""(?:[^"\\]|\\(.|\n))*"""'))) {
        _spans.add(_HighlightSpan(_HighlightType.string,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Multiline '''String'''
      if (_scanner.scan(RegExp(r"'''(?:[^'\\]|\\(.|\n))*'''"))) {
        _spans.add(_HighlightSpan(_HighlightType.string,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // "String"
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(_HighlightSpan(_HighlightType.string,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // 'String'
      if (_scanner.scan(RegExp(r"'(?:[^'\\]|\\.)*'"))) {
        _spans.add(_HighlightSpan(_HighlightType.string,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Double
      if (_scanner.scan(RegExp(r'\d+\.\d+'))) {
        _spans.add(_HighlightSpan(_HighlightType.number,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Integer
      if (_scanner.scan(RegExp(r'\d+'))) {
        _spans.add(_HighlightSpan(_HighlightType.number,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Punctuation
      if (_scanner.scan(RegExp(r'[\[\]{}().!=<>&\|\?\+\-\*/%\^~;:,]'))) {
        _spans.add(_HighlightSpan(_HighlightType.punctuation,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Meta data
      if (_scanner.scan(RegExp(r'@\w+'))) {
        _spans.add(_HighlightSpan(_HighlightType.keyword,
            _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        continue;
      }

      // Words
      if (_scanner.scan(RegExp(r'\w+'))) {
        _HighlightType? type;
        String word = _scanner.lastMatch?[0]??'';

        if (word.startsWith('_')) word = word.substring(1);

        if (language.containsKeywords(word)) {
          type = _HighlightType.keyword;
        } else if (language.containsInTypes(word)) {
          type = _HighlightType.keyword;
        } else if (_firstLetterIsUpperCase(word)) {
          type = _HighlightType.klass;
        } else if (word.length >= 2 &&
            word.startsWith('k') &&
            _firstLetterIsUpperCase(word.substring(1))) {
          type = _HighlightType.constant;
        }
        if (type != null) {
          _spans.add(_HighlightSpan(
              type, _scanner.lastMatch?.start??0, _scanner.lastMatch?.end??0));
        }
      }
      // Check if this loop did anything
      if (lastLoopPosition == _scanner.position) {
        // Failed to parse this file, abort gracefully
        return false;
      }
      lastLoopPosition = _scanner.position;
    }

    _simplify();
    return true;
  }

  void _simplify() {
    for (int i = _spans.length - 2; i >= 0; i -= 1) {
      if (_spans[i].type == _spans[i + 1].type && _spans[i].end == _spans[i + 1].start) {
        _spans[i] = _HighlightSpan(_spans[i].type, _spans[i].start, _spans[i + 1].end);
        _spans.removeAt(i + 1);
      }
    }
  }

  bool _firstLetterIsUpperCase(String str) {
    if (str.isNotEmpty) {
      final String first = str.substring(0, 1);
      return first == first.toUpperCase();
    }
    return false;
  }
}

enum _HighlightType {
  number,
  comment,
  keyword,
  string,
  punctuation,
  klass,
  constant
}

class _HighlightSpan {
  _HighlightSpan(this.type, this.start, this.end);

  final _HighlightType type;
  final int start;
  final int end;

  String textForSpan(String src) {
    return src.substring(start, end);
  }

  TextStyle? textStyle(HighlighterStyle? style) {
    if (type == _HighlightType.number) {
      return style?.numberStyle;
    } else if (type == _HighlightType.comment) {
      return style?.commentStyle;
    } else if (type == _HighlightType.keyword) {
      return style?.keywordStyle;
    } else if (type == _HighlightType.string) {
      return style?.stringStyle;
    } else if (type == _HighlightType.punctuation) {
      return style?.punctuationStyle;
    } else if (type == _HighlightType.klass) {
      return style?.classStyle;
    } else if (type == _HighlightType.constant) {
      return style?.constantStyle;
    } else {
      return style?.baseStyle;
    }
  }
}
