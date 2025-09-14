import 'package:fx_dao/fx_dao.dart';

class WidgetStatisticsDao extends Dao {
  @override
  String get createSql => '';

  @override
  String get name => 'widget_statistics';

  /// 获取各Family对应的组件数量
  Future<Map<int, int>> getFamilyCount() async {
    String sql = '''
      SELECT family, COUNT(*) as count 
      FROM widget 
      GROUP BY family
    ''';
    
    List<Map<String, dynamic>> result = await database.rawQuery(sql);
    Map<int, int> familyCount = {};
    
    for (var row in result) {
      familyCount[row['family'] as int] = row['count'] as int;
    }
    
    return familyCount;
  }

  /// 获取总组件数量
  Future<int> getTotalWidgets() async {
    String sql = 'SELECT COUNT(*) as count FROM widget';
    List<Map<String, dynamic>> result = await database.rawQuery(sql);
    return result.first['count'] as int;
  }

  /// 获取总字段数量
  Future<int> getTotalFields() async {
    String sql = 'SELECT COUNT(*) as count FROM widget_fields';
    List<Map<String, dynamic>> result = await database.rawQuery(sql);
    return result.first['count'] as int;
  }

  /// 获取星级分布
  Future<Map<int, int>> getLeverDistribution() async {
    String sql = '''
      SELECT CAST(lever as INTEGER) as lever_int, COUNT(*) as count 
      FROM widget 
      GROUP BY CAST(lever as INTEGER)
    ''';
    
    List<Map<String, dynamic>> result = await database.rawQuery(sql);
    Map<int, int> leverDistribution = {};
    
    for (var row in result) {
      leverDistribution[row['lever_int'] as int] = row['count'] as int;
    }
    
    return leverDistribution;
  }

  /// 获取平均字段数量
  Future<double> getAverageFields() async {
    String sql = '''
      SELECT AVG(field_count) as avg_fields
      FROM (
        SELECT widget_id, COUNT(*) as field_count
        FROM widget_fields
        GROUP BY widget_id
      )
    ''';
    
    List<Map<String, dynamic>> result = await database.rawQuery(sql);
    var avgFields = result.first['avg_fields'];
    return avgFields != null ? (avgFields as num).toDouble() : 0.0;
  }

  /// 获取每个组件的属性个数
  Future<Map<int, int>> getWidgetFieldsCount() async {
    String sql = '''
      SELECT widget_id, COUNT(*) as field_count
      FROM widget_fields
      GROUP BY widget_id
    ''';
    
    List<Map<String, dynamic>> result = await database.rawQuery(sql);
    Map<int, int> fieldsCount = {};
    
    for (var row in result) {
      fieldsCount[row['widget_id'] as int] = row['field_count'] as int;
    }
    
    return fieldsCount;
  }
}