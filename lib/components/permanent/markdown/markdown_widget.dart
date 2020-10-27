import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_unit/app/res/style/unit_text_style.dart';
import 'package:flutter_unit/app/res/style/unit_color.dart';
import 'package:flutter_unit/components/permanent/markdown/syntax_high_lighter.dart';


class MarkdownWidget extends StatelessWidget {
  static const int kWhite = 0;
  static const int kDarkLight = 1;
  static const int kDarkTheme = 2;

  final String markdownData;
  final int style;

  MarkdownWidget({this.markdownData = "", this.style = kWhite});

  MarkdownStyleSheet  _getCommonSheet(BuildContext context, Color codeBackground) {
    MarkdownStyleSheet markdownStyleSheet = MarkdownStyleSheet.fromTheme(Theme.of(context));
    return markdownStyleSheet.copyWith(
            codeblockDecoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: codeBackground,
                border: new Border.all(
                    color: UnitColor.subTextColor, width: 0.3)))
        .copyWith(
            blockquoteDecoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: UnitColor.subTextColor,
                border: new Border.all(
                    color: UnitColor.subTextColor, width: 0.3)),
            blockquote: TextStyleUnit.smallTextWhite);
  }

  _getStyleSheetDark(BuildContext context) {
    return _getCommonSheet(context, Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: TextStyleUnit.smallTextWhite,
      h1: TextStyleUnit.largeLargeTextWhite,
      h2: TextStyleUnit.largeTextWhiteBold,
      h3: TextStyleUnit.normalTextMitWhiteBold,
      h4: TextStyleUnit.middleTextWhite,
      h5: TextStyleUnit.smallTextWhite,
      h6: TextStyleUnit.smallTextWhite,
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: TextStyleUnit.middleTextWhiteBold,
      code: TextStyleUnit.smallSubText,
    );
  }

  MarkdownStyleSheet _getStyleSheetWhite(BuildContext context) {
    return _getCommonSheet(context, Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: TextStyleUnit.smallText,
      h1: TextStyleUnit.largeLargeText,
      h2: TextStyleUnit.largeTextBold,
      h3: TextStyleUnit.normalTextBold,
      h4: TextStyleUnit.middleText,
      h5: TextStyleUnit.smallText,
      h6: TextStyleUnit.smallText,
      strong: TextStyleUnit.middleTextBold,
      code: TextStyleUnit.smallSubText,
    );
  }

  _getStyleSheetTheme(BuildContext context) {
    return _getCommonSheet(context, Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: TextStyleUnit.smallTextWhite,
      h1: TextStyleUnit.largeLargeTextWhite,
      h2: TextStyleUnit.largeTextWhiteBold,
      h3: TextStyleUnit.normalTextMitWhiteBold,
      h4: TextStyleUnit.middleTextWhite,
      h5: TextStyleUnit.smallTextWhite,
      h6: TextStyleUnit.smallTextWhite,
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: TextStyleUnit.middleTextWhiteBold,
      code: TextStyleUnit.smallSubText,
    );
  }

  _getBackgroundColor(context) {
    Color background = UnitColor.white;
    switch (style) {
      case kDarkLight:
        background = UnitColor.primaryLightValue;
        break;
      case kDarkTheme:
        background = Theme.of(context).primaryColor;
        break;
    }
    return background;
  }

  _getStyle(BuildContext context) {
    MarkdownStyleSheet styleSheet = _getStyleSheetWhite(context);
    switch (style) {
      case kDarkLight:
        styleSheet = _getStyleSheetDark(context);
        break;
      case kDarkTheme:
        styleSheet = _getStyleSheetTheme(context);
        break;
    }
    return styleSheet;
  }

  _getMarkDownData(String markdownData) {
    ///优化图片显示
    RegExp exp = new RegExp(r'!\[.*\]\((.+)\)');
    RegExp expImg = new RegExp("<img.*?(?:>|\/>)");
    RegExp expSrc = new RegExp("src=[\'\"]?([^\'\"]*)[\'\"]?");

    String mdDataCode = markdownData;
    try {
      Iterable<Match> tags = exp.allMatches(markdownData);
      if (tags != null && tags.length > 0) {
        for (Match m in tags) {
          String imageMatch = m.group(0);
          if (imageMatch != null && !imageMatch.contains(".svg")) {
            String match = imageMatch.replaceAll("\)", "?raw=true)");
            if (!match.contains(".svg") && match.contains("http")) {
              ///增加点击
              String src = match
                  .replaceAll(new RegExp(r'!\[.*\]\('), "")
                  .replaceAll(")", "");
              String actionMatch = "[$match]($src)";
              match = actionMatch;
            } else {
              match = "";
            }
            mdDataCode = mdDataCode.replaceAll(m.group(0), match);
          }
        }
      }

      ///优化img标签的src资源
      tags = expImg.allMatches(markdownData);
      if (tags != null && tags.length > 0) {
        for (Match m in tags) {
          String imageTag = m.group(0);
          String match = imageTag;
          if (imageTag != null) {
            Iterable<Match> srcTags = expSrc.allMatches(imageTag);
            for (Match srcMatch in srcTags) {
              String srcString = srcMatch.group(0);
              if (srcString != null && srcString.contains("http")) {
                String newSrc = srcString.substring(
                        srcString.indexOf("http"), srcString.length - 1) +
                    "?raw=true";
                match = "[![]($newSrc)]($newSrc)";
              }
            }
          }
          mdDataCode = mdDataCode.replaceAll(imageTag, match);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return mdDataCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getBackgroundColor(context),
      padding: EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: new MarkdownBody(
          styleSheet: _getStyle(context),
          syntaxHighlighter: new GSYHighlighter(),
          data: _getMarkDownData(markdownData),
          onTapLink: (String source) {
//            CommonUtils.launchUrl(context, source);
          },
        ),
      ),
    );
  }
}

class GSYHighlighter extends SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    String showSource = source.replaceAll("&lt;", "<");
    showSource = showSource.replaceAll("&gt;", ">");
    return new DartSyntaxHighlighter().format(showSource);
  }
}
