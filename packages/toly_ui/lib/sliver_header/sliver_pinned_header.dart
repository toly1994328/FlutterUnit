import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverPinnedHeader extends StatelessWidget {
  final PreferredSizeWidget child;
  final Color color;

  SliverPinnedHeader({required this.child, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverPinnedHeaderDelegate(
          child: child,
          color: color
      ),
    );
  }
}

class _SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color color;


  _SliverPinnedHeaderDelegate({required this.child, required this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return ColoredBox(
        color: color,
        child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child
    ||oldDelegate.color != color;
  }
}