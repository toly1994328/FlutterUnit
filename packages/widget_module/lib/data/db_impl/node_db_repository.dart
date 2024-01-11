
import 'package:storage/storage.dart';


import '../model/node_model.dart';
import '../node_repository.dart';

class NodeDbRepository implements NodeRepository{

  const NodeDbRepository();

  NodeDao get nodeDao => FlutterDbStorage.instance.nodeDao;

  @override
  Future<List<NodeModel>> loadNode(int widgetId) async{
    List<Map<String, dynamic>> data = await nodeDao.queryById(widgetId);
    List<NodeModel> nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

}