import '../../algorithm/finding/functions.dart';


class FindingConfig {
  final XY size;
  final int seed;
  final FindingAlgo algo;

  FindingConfig({
    this.seed = -1,
    this.algo = FindingAlgo.bfs,
    this.size = (31, 31),
  });

  FindingConfig copyWith({
    XY? size,
    int? seed,
    FindingAlgo? algo,
  }) =>
      FindingConfig(
        size: size ?? this.size,
        seed: seed ?? this.seed,
        algo: algo ?? this.algo,
      );
}
