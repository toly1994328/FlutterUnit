import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/ext.dart';
import 'package:toly_ui/toly_ui.dart';

import '../search_page/standard_search_page.dart';

class StandardHomeSearch extends StatelessWidget
    implements PreferredSizeWidget {
  const StandardHomeSearch({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDark ? Colors.transparent : Colors.white,
      child: Row(
        children: [
          _buildHead(context),
          Expanded(
            child: GestureDetector(
              onTap: () => _toSearchPage(context),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 35,
                  child: TextField(
                    autofocus: false,
                    enabled: false,
                    cursorColor: Colors.blue,
                    maxLines: 1,
                    decoration: _topSearchInputDecoration(isDark, context),
                  )),
            ),
          ),
          _buildCollectIcon(context),
        ],
      ),
    );
  }

  InputDecoration _topSearchInputDecoration(bool isDark, BuildContext context) {
    String hintText = context.l10n.searchWidget;
    return InputDecoration(
        filled: true,
        fillColor: isDark ? const Color(0xff292929) : const Color(0xffF3F6F9),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(35 / 2)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14));
  }

  Widget _buildHead(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: FeedbackWidget(
        onPressed: () => _openDrawer(context),
        child: const CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('assets/images/icon_head.webp'),
        ),
      ),
    );
  }

  Widget _buildCollectIcon(BuildContext context) {
    return IconButton(
      // splashRadius: 20,
      onPressed: () => context.push('/collect'),
      icon: const Icon(TolyIcon.icon_collect),
    );
  }

  void _toSearchPage(BuildContext context) {
    Navigator.of(context)
        .push(FadePageRoute(child: const StandardSearchPageProvider()));
  }

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
