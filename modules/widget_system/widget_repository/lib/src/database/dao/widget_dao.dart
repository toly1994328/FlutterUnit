import 'package:fx_dao/fx_dao.dart';
import '../../model/widget_filter.dart';
import '../po/widget_po.dart';

class WidgetDao with HasDatabase, DbTable {
  @override
  String get createSql => '';

  @override
  String get name => 'widget';


  Future<List<Map<String, dynamic>>> queryByIds(List<int> ids, String? locale) async {
    if (ids.isEmpty) {
      return [];
    }
    String searchSql = """
SELECT 
  widget.id, 
  widget.name,
  widget.family,
  widget.linkWidget,
  widget.lever,
  widget_desc.name AS nameCN, 
  widget_desc.info
FROM widget
INNER JOIN widget_desc 
  ON widget.id = widget_desc.widget_id
WHERE 
  widget_desc.locale = ? AND 
  widget.id in (${'?,' * (ids.length - 1)}?)
ORDER BY 
  lever DESC, widget.id ASC;
    """;

    return database.rawQuery(searchSql, [(locale?? 'zh-cn'), ...ids]);
  }

  Future<List<Map<String, dynamic>>> search(WidgetFilter arguments) async {
    // 保证 name 参数为空时，不进行搜索
    if (arguments.name.isEmpty) {
      return [];
    }

    // * 表示 name 任意
    String name = arguments.name == '*' ? '' : arguments.name;
    bool hasFamily = arguments.family != null;
    String familySql = hasFamily ? ' AND family = ?' : '';
    List<int> familyArg = hasFamily ? [arguments.family!.index] : [];
    List<int> starArg = arguments.stars;
    if (arguments.stars.reduce((a, b) => a + b) == -5) {
      starArg = [1, 2, 3, 4, 5];
    }
    String searchSql = """
SELECT 
  widget.id, 
  widget.name,
  widget.family,
  widget.linkWidget,
  widget.lever,
  widget_desc.name AS nameCN, 
  widget_desc.info
FROM widget
INNER JOIN widget_desc 
  ON widget.id = widget_desc.widget_id
WHERE 
widget_desc.locale = ? 
AND (widget.name LIKE ? OR widget_desc.info LIKE ? OR widget_desc.name LIKE ?) 
$familySql 
AND lever IN(?,?,?,?,?) 
ORDER BY 
  lever DESC, widget.id ASC 
LIMIT ? OFFSET ? 
;
    """;

    return database.rawQuery(searchSql,
        [
          arguments.locale?? 'zh-cn',
          "%$name%",
          "%$name%",
          "%$name%",
          ...familyArg,
          ...starArg,
          arguments.pageSize,
          arguments.offset
        ]);
  }

  Future<int> total(WidgetFilter args) async {
    bool hasFamily = args.family != null;
    String familySql = hasFamily ? 'family = ?' : '';
    List<int> familyArg = hasFamily ? [args.family!.index] : [];

    String sql = "SELECT count(id) as `count` FROM widget WHERE $familySql";

    List<Map<String, Object?>> result = await database.rawQuery(sql, familyArg);
    if (result.isNotEmpty) {
      return result.first['count'] as int ?? 0;
    }
    return 0;
  }

  Future<Map<String, dynamic>?> queryWidgetByName(String name, {String? locale}) async {
    String querySql = """
SELECT 
  widget.id, 
  widget.name,
  widget.family,
  widget.linkWidget,
  widget.lever,
  widget_desc.name AS nameCN, 
  widget_desc.info
FROM widget
INNER JOIN widget_desc 
  ON widget.id = widget_desc.widget_id
WHERE 
widget.name = ? AND 
widget_desc.locale = ? 
;
""";
    List<Map<String, Object?>> result = await database.rawQuery(querySql, [name,locale??'zh-cn']);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
