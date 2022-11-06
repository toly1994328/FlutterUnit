
import 'package:db_storage/db_storage.dart';
import 'package:widget_repository/src/model/node_model.dart';

import '../node_repository.dart';

class NodeDbRepository implements NodeRepository{

  const NodeDbRepository();

  NodeDao get nodeDao => LocalDb.instance.nodeDao;

  @override
  Future<List<NodeModel>> loadNode(int widgetId) async{
    List<Map<String, dynamic>> data = await nodeDao.queryById(widgetId);
    List<NodeModel> nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

}