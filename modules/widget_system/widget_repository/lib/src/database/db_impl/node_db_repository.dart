
import 'package:storage/storage.dart';
import 'package:widget_repository/widget_repository.dart';

class NodeDbRepository implements NodeRepository{

  const NodeDbRepository();

  NodeDao get nodeDao => AppStorage().flutter<NodeDao>();

  @override
  Future<List<NodeModel>> loadNode(int widgetId) async{
    List<Map<String, dynamic>> data = await nodeDao.queryById(widgetId);
    List<NodeModel> nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

}