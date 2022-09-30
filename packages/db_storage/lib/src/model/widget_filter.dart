import 'enums.dart';

class WidgetFilter {
  final String name;
  final WidgetFamily? family;
  final List<int> stars;

  const WidgetFilter({
    this.name = '',
    this.family,
    this.stars = const [-1, -1, -1, -1, -1],
  });

  WidgetFilter.family(
    this.family, {
    this.name = '*',
    this.stars = const [1, 2, 3, 4, 5],
  });

  WidgetFilter copyWith({
    String? name,
    WidgetFamily? family,
    List<int>? stars,
  }) {
    return WidgetFilter(
      name: name ?? this.name,
      family: family ?? this.family,
      stars: stars ?? this.stars,
    );
  }

  @override
  String toString() {
    return 'WidgetFilter{name: $name, family: $family, stars: $stars}';
  }
}
