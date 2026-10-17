import 'package:flutter/widgets.dart';

/// 懒加载的分页首次访问后保留状态，隐藏时暂停后代动画。
class RetainedPage extends StatefulWidget {
  /// 当前页面是否处于选中状态。
  final bool active;

  /// 保留滚动、输入和数据控制器的完整页面子树。
  final Widget child;
  const RetainedPage({super.key, required this.active, required this.child});
  @override
  State<RetainedPage> createState() => _RetainedPageState();
}

class _RetainedPageState extends State<RetainedPage>
    with AutomaticKeepAliveClientMixin<RetainedPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TickerMode(
        enabled: widget.active,
        child: ExcludeFocus(excluding: !widget.active, child: widget.child));
  }
}
