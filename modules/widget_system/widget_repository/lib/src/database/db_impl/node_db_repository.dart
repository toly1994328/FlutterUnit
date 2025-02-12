
import 'package:storage/storage.dart';
import 'package:widget_repository/widget_repository.dart';

class NodeDbRepository implements NodeRepository{

  const NodeDbRepository();

  NodeDao get nodeDao => AppStorage().flutter<NodeDao>();

  @override
  Future<List<NodeModel>> loadNode(int widgetId,{String? locale}) async{
    List<Map<String, dynamic>> data = await nodeDao.queryById(widgetId,locale: locale);
    List<NodeModel> nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

}