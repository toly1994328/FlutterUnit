
class SortConfig {
  final int count;
  final int seed;
  final Duration duration;
  final String name;

  SortConfig({
     this.count = 100,
     this.duration = const Duration(microseconds: 1500),
     this.seed = -1,
     this.name = 'insertion',
  });

  SortConfig copyWith({
    int? count,
    int? seed,
    Duration? duration,
    String? name,
  }) =>
      SortConfig(
        count:count??this.count,
        seed:seed??this.seed,
        duration:duration??this.duration,
        name:name??this.name,
      );
}

