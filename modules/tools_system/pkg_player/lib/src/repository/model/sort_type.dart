import 'package:flutter/material.dart';
import 'package:pkg_player/src/l10n/l10n.dart';

enum SortType {
  downloads('downloads'),
  likes('likes'),
  publishTime('publish_time');

  const SortType(this.value);

  final String value;

  String getLabel(BuildContext context) {
    switch (this) {
      case SortType.downloads:
        return context.pkgL10n.downloads;
      case SortType.likes:
        return context.pkgL10n.likes;
      case SortType.publishTime:
        return context.pkgL10n.publishTime;
    }
  }
}
