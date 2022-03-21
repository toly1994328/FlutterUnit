/// create by 张风捷特烈 on 2021/1/21
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class Language {
  final String name;

  const Language(this.name);

  bool containsKeywords(String word);

  bool containsInTypes(String word);

  List<String> get keywords;

  List<String> get inTypes;
}
