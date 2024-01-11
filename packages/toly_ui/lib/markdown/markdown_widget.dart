import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'md_text_styles.dart';
import 'syntax_high_lighter.dart';


class MarkdownWidget extends StatelessWidget {
  static const int kWhite = 0;
  static const int kDarkLight = 1;
  static const int kDarkTheme = 2;

  final String markdownData;
  final int style;

  const MarkdownWidget({Key? key, this.markdownData = "", this.style = kWhite}) : super(key: key);

  MarkdownStyleSheet  _getCommonSheet(BuildContext context, Color codeBackground) {
    MarkdownStyleSheet markdownStyleSheet = MarkdownStyleSheet.fromTheme(Theme.of(context));
    return markdownStyleSheet.copyWith(
            codeblockDecoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                color: codeBackground,
                border:  Border.all(
                    color: MdTextStyles.subTextColor, width: 0.3)))
        .copyWith(
            blockquoteDecoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                color: MdTextStyles.subTextColor,
                border:  Border.all(
                    color: MdTextStyles.subTextColor, width: 0.3)),
            blockquote: MdTextStyles.smallTextWhite);
  }

  _getStyleSheetDark(BuildContext context) {
    return _getCommonSheet(context, const Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: MdTextStyles.smallTextWhite,
      h1: MdTextStyles.largeLargeTextWhite,
      h2: MdTextStyles.largeTextWhiteBold,
      h3: MdTextStyles.normalTextMitWhiteBold,
      h4: MdTextStyles.middleTextWhite,
      h5: MdTextStyles.smallTextWhite,
      h6: MdTextStyles.smallTextWhite,
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: MdTextStyles.middleTextWhiteBold,
      code: MdTextStyles.smallSubText,
    );
  }

  MarkdownStyleSheet _getStyleSheetWhite(BuildContext context) {
    return _getCommonSheet(context, const Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: MdTextStyles.smallText,
      h1: MdTextStyles.largeLargeText,
      h2: MdTextStyles.largeTextBold,
      h3: MdTextStyles.normalTextBold,
      h4: MdTextStyles.middleText,
      h5: MdTextStyles.smallText,
      h6: MdTextStyles.smallText,
      strong: MdTextStyles.middleTextBold,
      code: MdTextStyles.smallSubText,
    );
  }

  _getStyleSheetTheme(BuildContext context) {
    return _getCommonSheet(context, const Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: MdTextStyles.smallTextWhite,
      h1: MdTextStyles.largeLargeTextWhite,
      h2: MdTextStyles.largeTextWhiteBold,
      h3: MdTextStyles.normalTextMitWhiteBold,
      h4: MdTextStyles.middleTextWhite,
      h5: MdTextStyles.smallTextWhite,
      h6: MdTextStyles.smallTextWhite,
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: MdTextStyles.middleTextWhiteBold,
      code: MdTextStyles.smallSubText,
    );
  }

  _getBackgroundColor(context) {
    Color background = MdTextStyles.white;
    switch (style) {
      case kDarkLight:
        background = MdTextStyles.primaryLightValue;
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
    RegExp exp =  RegExp(r'!\[.*\]\((.+)\)');
    RegExp expImg =  RegExp("<img.*?(?:>|/>)");
    RegExp expSrc =  RegExp("src=['\"]?([^'\"]*)['\"]?");

    String mdDataCode = markdownData;
    try {
      Iterable<Match> tags = exp.allMatches(markdownData);
      if (tags.isNotEmpty) {
        for (Match m in tags) {
          String imageMatch = m.group(0)??'';
          if (!imageMatch.contains(".svg")) {
            String match = imageMatch.replaceAll(")", "?raw=true)");
            if (!match.contains(".svg") && match.contains("http")) {
              ///增加点击
              String src = match
                  .replaceAll( RegExp(r'!\[.*\]\('), "")
                  .replaceAll(")", "");
              String actionMatch = "[$match]($src)";
              match = actionMatch;
            } else {
              match = "";
            }
            mdDataCode = mdDataCode.replaceAll(m.group(0)??'', match);
          }
        }
      }

      ///优化img标签的src资源
      tags = expImg.allMatches(markdownData);
      if (tags.isNotEmpty) {
        for (Match m in tags) {
          String imageTag = m.group(0)??'';
          String match = imageTag;
          Iterable<Match> srcTags = expSrc.allMatches(imageTag);
          for (Match srcMatch in srcTags) {
            String srcString = srcMatch.group(0)??'';
            if (srcString.contains("http")) {
              String newSrc = srcString.substring(
                      srcString.indexOf("http"), srcString.length - 1) +
                  "?raw=true";
              match = "[![]($newSrc)]($newSrc)";
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
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child:  MarkdownBody(
          styleSheet: _getStyle(context),
          syntaxHighlighter:  Highlighter(),
          data: _getMarkDownData(markdownData),
          onTapLink: (String text, String? href, String title) {
//            CommonUtils.launchUrl(context, source);
          },
        ),
      ),
    );
  }
}

class Highlighter extends SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    String showSource = source.replaceAll("&lt;", "<");
    showSource = showSource.replaceAll("&gt;", ">");
    return  DartSyntaxHighlighter().format(showSource);
  }
}
