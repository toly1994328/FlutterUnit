import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 布局宝库总览页面。
class LayoutOverview extends StatelessWidget {
  const LayoutOverview({super.key});

  /// 按能力域组织的布局主题。
  static const List<_OverviewSection> _sections = <_OverviewSection>[
    _OverviewSection(
      title: '基本布局',
      items: <_OverviewItem>[
        _OverviewItem('/base/size', 'Size', '布局尺寸', Icons.aspect_ratio),
        _OverviewItem('/base/constraints', 'Constraints', '约束系统',
            Icons.fit_screen_outlined),
        _OverviewItem('/base/padding', 'Padding', '布局边距', Icons.padding),
        _OverviewItem(
            '/base/align', 'Align', '布局对齐', Icons.align_horizontal_center),
        _OverviewItem(
            '/base/positioned', 'Positioned', '布局定位', Icons.control_camera),
      ],
    ),
    _OverviewSection(
      title: '多子布局',
      items: <_OverviewItem>[
        _OverviewItem('/multi/flex', 'Flex', '线性布局', Icons.view_week_outlined),
        _OverviewItem(
            '/multi/flex-space', 'Flex Space', '空间分配', Icons.space_bar_rounded),
        _OverviewItem('/multi/wrap', 'Wrap', '流式布局', Icons.wrap_text),
        _OverviewItem('/multi/stack', 'Stack', '堆叠布局', Icons.layers_outlined),
      ],
    ),
    _OverviewSection(
      title: '滑动布局',
      items: <_OverviewItem>[
        _OverviewItem(
            '/scroll/list', 'ListView', '列表布局', Icons.view_list_outlined),
        _OverviewItem(
            '/scroll/grid', 'GridView', '网格布局', Icons.grid_view_outlined),
        _OverviewItem(
            '/scroll/page', 'PageView', '滑页布局', Icons.view_carousel_outlined),
      ],
    ),
    _OverviewSection(
      title: '菜单浮层',
      items: <_OverviewItem>[
        _OverviewItem('/popable/DropdownButton', 'DropdownButton', '下拉按钮',
            Icons.arrow_drop_down_circle_outlined),
        _OverviewItem('/popable/DropdownMenu', 'DropdownMenu', '下拉菜单',
            Icons.menu_open_rounded),
        _OverviewItem('/popable/Autocomplete', 'Autocomplete', '自动填充',
            Icons.manage_search_rounded),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columnCount = _resolveColumnCount(constraints.maxWidth);
        return CustomScrollView(
          slivers: _buildSections(context, columnCount),
        );
      },
    );
  }

  int _resolveColumnCount(double width) {
    if (width >= 1000) {
      return 4;
    }
    if (width >= 700) {
      return 3;
    }
    if (width >= 440) {
      return 2;
    }
    return 1;
  }

  /// 将分组数据转换为连续的标题和网格 Sliver。
  List<Widget> _buildSections(BuildContext context, int columnCount) {
    final List<Widget> slivers = <Widget>[
      const SliverPadding(padding: EdgeInsets.only(top: 8)),
    ];
    for (final _OverviewSection section in _sections) {
      slivers.add(_buildSectionHeader(context, section));
      slivers.add(_buildSectionGrid(section, columnCount));
    }
    slivers.add(const SliverPadding(padding: EdgeInsets.only(bottom: 24)));
    return slivers;
  }

  Widget _buildSectionHeader(
    BuildContext context,
    _OverviewSection section,
  ) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Row(
          children: <Widget>[
            Text(
              section.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              '${section.items.length}',
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionGrid(_OverviewSection section, int columnCount) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid.builder(
        itemCount: section.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
          mainAxisSpacing: 4,
          crossAxisSpacing: 8,
          mainAxisExtent: 64,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _OverviewTile(item: section.items[index]);
        },
      ),
    );
  }
}

class _OverviewTile extends StatelessWidget {
  const _OverviewTile({required this.item});

  /// 总览条目的统一强调色。
  static const Color _accentColor = Color(0xff1677ff);

  /// 当前布局主题。
  final _OverviewItem item;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(item.path),
        hoverColor: isDark ? const Color(0xff292c31) : const Color(0xfff5f6f8),
        highlightColor:
            isDark ? const Color(0xff30343a) : const Color(0xffeef0f3),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 2),
              Icon(item.icon, size: 20, color: _accentColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.localName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewSection {
  const _OverviewSection({required this.title, required this.items});

  /// 分组标题。
  final String title;

  /// 分组内布局主题。
  final List<_OverviewItem> items;
}

class _OverviewItem {
  const _OverviewItem(
    this.path,
    this.name,
    this.localName,
    this.icon,
  );

  /// 布局主题路由。
  final String path;

  /// 布局英文名称。
  final String name;

  /// 布局中文名称。
  final String localName;

  /// 布局示意图标。
  final IconData icon;
}
