import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/display_logic.dart';
import '../../bloc/display_state.dart';
import '../../data/model/display_frame.dart';

class PlaygroundTopBar extends StatelessWidget {
  const PlaygroundTopBar({super.key});

  /// GitHub 仓库源码基础地址。
  static const String _repositorySourceUrl =
      'https://github.com/toly1994328/FlutterUnit/blob/master/';

  @override
  Widget build(BuildContext context) {
    DisplayState state = DisplayScope.of(context).state;
    DisplayFrame frame = state.frame;
    const ActionStyle style =
        ActionStyle.light(backgroundColor: Color(0xffd5d5d5));
    return Container(
      color: const Color(0xfff2f2f2),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 46,
      child: NavigationToolbar(
        centerMiddle: true,
        leading: UnconstrainedBox(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '当前: ${state.activeIndex + 1}/${state.total}',
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              )),
        ),
        middle: Text(
          frame.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Wrap(
          children: [
            TolyAction(
                style: style,
                child: const Icon(Icons.skip_previous, size: 20),
                onTap: () {
                  DisplayScope.of(context).prevPage();
                }),
            TolyAction(
                style: style,
                child: const Icon(Icons.skip_next, size: 20),
                onTap: () {
                  DisplayScope.of(context).nextPage();
                }),
            TolyAction(
              style: style,
              child: const Icon(Icons.code, size: 20),
              onTap: () => _openSource(context, frame),
            ),
          ],
        ),
      ),
    );
  }

  /// 在外部浏览器中打开当前案例源码，失败时复制仓库内路径。
  Future<void> _openSource(
    BuildContext context,
    DisplayFrame frame,
  ) async {
    if (frame.src.isEmpty) {
      _showMessage(context, '该案例暂未登记源码路径');
      return;
    }

    final Uri sourceUri = Uri.parse('$_repositorySourceUrl${frame.src}');
    final bool opened = await launchUrl(
      sourceUri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      await Clipboard.setData(ClipboardData(text: frame.src));
      if (context.mounted) {
        _showMessage(context, '无法打开浏览器，源码路径已复制');
      }
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
