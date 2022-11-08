
import 'model/model.dart';

abstract class NodeRepository{

  Future<List<NodeModel>> loadNode(int widgetId);

}




