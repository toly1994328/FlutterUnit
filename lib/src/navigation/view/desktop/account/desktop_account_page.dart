import 'package:app/app.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_module/widget_module.dart';

/// 在应用组合层连接账号总览和组件收藏，保持两个业务模块单向依赖。
class DesktopAccountPage extends StatefulWidget {
  const DesktopAccountPage({super.key});

  @override
  State<DesktopAccountPage> createState() => _DesktopAccountPageState();
}

class _DesktopAccountPageState extends State<DesktopAccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<LikeWidgetBloc>().loadLikeData();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LikeWidgetBloc, List<WidgetModel>>(builder: _buildOverview);

  Widget _buildOverview(BuildContext context, List<WidgetModel> favorites) {
    return DesktopUserPage(
        collectionCount: favorites.length,
        collectionContent:
            _CollectionPreview(items: favorites.take(4).toList()));
  }
}

/// 预览使用真实收藏，点击进入原组件详情，完整列表仍走原收藏入口。
class _CollectionPreview extends StatelessWidget {
  const _CollectionPreview({required this.items});

  /// 从本地收藏读取的至多四个组件。
  final List<WidgetModel> items;

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: _buildGrid);

  /// 只约束每张卡片的宽度，高度由封面和文字自然撑开。
  Widget _buildGrid(BuildContext context, BoxConstraints constraints) {
    const double spacing = 12;
    final int columns = constraints.maxWidth >= 260 ? 2 : 1;
    final double tileWidth =
        (constraints.maxWidth - spacing * (columns - 1)) / columns;
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: <Widget>[
        for (final WidgetModel item in items)
          SizedBox(width: tileWidth, child: _FavoriteTile(model: item)),
      ],
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({required this.model});

  /// 当前收藏组件的完整详情模型。
  final WidgetModel model;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainerLowest,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
        side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: () => _openDetail(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Center(
                // SVG 画布自带透明边距，收起上下留白，保留封面的显示尺寸。
                child: ClipRect(
                  child: Align(
                    widthFactor: 1,
                    heightFactor: 0.9,
                    child: SvgPicture.asset(
                      'assets/images/widgets/${model.name}.svg',
                      width: 104,
                      height: 104,
                      fit: BoxFit.contain,
                      errorBuilder: _buildCoverFallback,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(model.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13,
                          height: 1.2,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(model.nameCN,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: colors.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 新组件缺少独立资源时使用通用 SVG，正常组件保留各自封面的原始颜色。
  Widget _buildCoverFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) =>
      SvgPicture.asset('assets/images/widgets/Widget.svg', fit: BoxFit.contain);

  void _openDetail(BuildContext context) => Navigator.of(context)
      .push(SlidePageRoute(child: WidgetDetailPageScope(model: model)));
}
