import 'enums.dart';



class WidgetFilter {
  final String name;
  final WidgetFamily? family;
  final List<int> stars;
  final int page;
  final int pageSize;

  const WidgetFilter({
    this.name = '',
    this.family,
    this.stars = const [-1, -1, -1, -1, -1],
    this.page = 1,
    this.pageSize = 20,
  });

  int get offset =>pageSize*(page-1);

  WidgetFilter.family(
    this.family, {
    this.name = '*',
    this.page = 1,
    this.pageSize = 20,
    this.stars = const [1, 2, 3, 4, 5],
  });

  WidgetFilter copyWith({
    String? name,
    WidgetFamily? family,
    List<int>? stars,
    int? page,
  }) {
    return WidgetFilter(
      name: name ?? this.name,
      family: family ?? this.family,
      stars: stars ?? this.stars,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'WidgetFilter{name: $name, family: $family, stars: $stars, page: $page}';
  }
}
