import 'package:layout/src/data/model/display_frame.dart';

import '../data/display_map/display_map.dart';

class DisplayState {
  final String router;
  final int activeIndex;
  final int total;

  DisplayState({
    required this.router,
    required this.activeIndex,
    required this.total,
  });

  DisplayFrame get frame {
    return kDisplayMap[router]![activeIndex];
  }

  DisplayState copyWith({
    int? total,
    int? activeIndex,
    String? router,
  }) =>
      DisplayState(
        router: router ?? this.router,
        activeIndex: activeIndex ?? this.activeIndex,
        total: total ?? this.total,
      );
}
