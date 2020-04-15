// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import 'highlighter_style.dart';

/// final SyntaxHighlighterStyle style = SyntaxHighlighterStyle.lightThemeStyle();
/// DartSyntaxHighlighter(style).format(source)

abstract class Highlighter { // ignore: one_member_abstracts
  TextSpan format(String src);
}

//暗黑模式下的高亮样式
class DartHighlighter extends Highlighter {
  DartHighlighter([HighlighterStyle style]) :
    this._style = style ?? HighlighterStyle.fromColors(HighlighterStyle.lightColor);

  HighlighterStyle _style;

  static const List<String> _keywords = <String>[
    'abstract', 'as', 'assert', 'async', 'await', 'break', 'case', 'catch',
    'class', 'const', 'continue', 'default', 'deferred', 'do', 'dynamic', 'else',
    'enum', 'export', 'external', 'extends', 'factory', 'false', 'final',
    'finally', 'for', 'get', 'if', 'implements', 'import', 'in', 'is', 'library',
    'new', 'null', 'operator', 'part', 'rethrow', 'return', 'set', 'static',
    'super', 'switch', 'sync', 'this', 'throw', 'true', 'try', 'typedef', 'var',
    'void', 'while', 'with', 'yield'
  ];

  static const List<String> _builtInTypes = <String>[
    'int', 'double', 'num', 'bool'
  ];

  @override
  TextSpan format(String src) {
    List<_HighlightSpan> _spans = _generateSpans(src);
    if (_spans != null) {
      // Successfully parsed the code
      final List<TextSpan> formattedText = <TextSpan>[];
      int currentPosition = 0;

      for (_HighlightSpan span in _spans) {
        if (currentPosition != span.start)
          formattedText.add(TextSpan(text: src.substring(currentPosition, span.start)));

        formattedText.add(TextSpan(style: span.textStyle(_style), text: span.textForSpan(src)));

        currentPosition = span.end;
      }

      if (currentPosition != src.length)
        formattedText.add(TextSpan(text: src.substring(currentPosition, src.length)));

      return TextSpan(style: _style.baseStyle, children: formattedText);
    } else {
      // Parsing failed, return with only basic formatting
      return TextSpan(style: _style.baseStyle, text: src);
    }
  }

  static List<_HighlightSpan> _generateSpans(String src) {
    StringScanner _scanner = StringScanner(src);
    List<_HighlightSpan> _spans = [];
    int lastLoopPosition = _scanner.position;

    while (!_scanner.isDone) {
      // Skip White space
      _scanner.scan(RegExp(r'\s+'));

      // Block comments
      if (_scanner.scan(RegExp(r'/\*(.|\n)*\*/'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.comment,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Line comments
      if (_scanner.scan('//')) {
        final int startComment = _scanner.lastMatch.start;

        bool eof = false;
        int endComment;
        if (_scanner.scan(RegExp(r'.*\n'))) {
          endComment = _scanner.lastMatch.end - 1;
        } else {
          eof = true;
          endComment = src.length;
        }

        _spans.add(_HighlightSpan(
            _HighlightType.comment,
            startComment,
            endComment
        ));

        if (eof)
          break;

        continue;
      }

      // Raw r"String"
      if (_scanner.scan(RegExp(r'r".*"'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Raw r'String'
      if (_scanner.scan(RegExp(r"r'.*'"))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Multiline """String"""
      if (_scanner.scan(RegExp(r'"""(?:[^"\\]|\\(.|\n))*"""'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Multiline '''String'''
      if (_scanner.scan(RegExp(r"'''(?:[^'\\]|\\(.|\n))*'''"))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // "String"
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // 'String'
      if (_scanner.scan(RegExp(r"'(?:[^'\\]|\\.)*'"))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Double
      if (_scanner.scan(RegExp(r'\d+\.\d+'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.number,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Integer
      if (_scanner.scan(RegExp(r'\d+'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.number,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end)
        );
        continue;
      }

      // Punctuation
      if (_scanner.scan(RegExp(r'[\[\]{}().!=<>&\|\?\+\-\*/%\^~;:,]'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.punctuation,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Meta data
      if (_scanner.scan(RegExp(r'@\w+'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.keyword,
            _scanner.lastMatch.start,
            _scanner.lastMatch.end
        ));
        continue;
      }

      // Words
      if (_scanner.scan(RegExp(r'\w+'))) {
        _HighlightType type;

        String word = _scanner.lastMatch[0];
        if (word.startsWith('_'))
          word = word.substring(1);

        if (_keywords.contains(word))
          type = _HighlightType.keyword;
        else if (_builtInTypes.contains(word))
          type = _HighlightType.keyword;
        else if (_firstLetterIsUpperCase(word))
          type = _HighlightType.klass;
        else if (word.length >= 2 && word.startsWith('k') && _firstLetterIsUpperCase(word.substring(1)))
          type = _HighlightType.constant;

        if (type != null) {
          _spans.add(_HighlightSpan(
              type,
              _scanner.lastMatch.start,
              _scanner.lastMatch.end
          ));
        }
      }

      // Check if this loop did anything
      if (lastLoopPosition == _scanner.position) {
        // Failed to parse this file, abort gracefully
        return null;
      }
      lastLoopPosition = _scanner.position;
    }

    _simplify(_spans);
    return _spans;
  }

  static void _simplify(List<_HighlightSpan> spans) {
    for (int i = spans.length - 2; i >= 0; i -= 1) {
      var span = spans[i];
      var span2 = spans[i + 1];
      if (span.type == span2.type && span.end == span2.start) {
        spans[i] = _HighlightSpan(
            span.type,
            span.start,
            span2.end
        );
        spans.removeAt(i + 1);
      }
    }
  }

  static bool _firstLetterIsUpperCase(String str) {
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

  TextStyle textStyle(HighlighterStyle style) {
    if (type == _HighlightType.number)
      return style.numberStyle;
    else if (type == _HighlightType.comment)
      return style.commentStyle;
    else if (type == _HighlightType.keyword)
      return style.keywordStyle;
    else if (type == _HighlightType.string)
      return style.stringStyle;
    else if (type == _HighlightType.punctuation)
      return style.punctuationStyle;
    else if (type == _HighlightType.klass)
      return style.classStyle;
    else if (type == _HighlightType.constant)
      return style.constantStyle;
    else
      return style.baseStyle;
  }
}
