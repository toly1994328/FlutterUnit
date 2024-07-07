
import '../../finding/data_scope/finding_state.dart';
import 'functions/AStar.dart';
import 'functions/BestFS.dart';
import 'functions/BFS.dart';
import 'functions/DFS.dart';
import 'functions/dijkstra.dart';

typedef XY = (int,int);

typedef FindFunction = Future<bool> Function(FindingState state);

enum FindingAlgo {
  bfs('BFS'),
  dfs('DFS'),
  aStar('AStar'),
  bestFS('BestFS'),
  dijkstra('dijkstra'),
  ;

  final String path;

  const FindingAlgo(this.path);

  FindFunction get function{
    return switch(this){
      FindingAlgo.bfs => findingBFS,
      FindingAlgo.dfs => findingDFS,
      FindingAlgo.aStar => findingAStar,
      FindingAlgo.bestFS => findingBestFS,
      FindingAlgo.dijkstra => findingDijkstra,
    };
  }
}

