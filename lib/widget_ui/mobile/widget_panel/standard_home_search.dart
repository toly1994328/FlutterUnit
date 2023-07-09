import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:components/toly_ui/toly_ui.dart';

import '../search_page/standard_search_page.dart';

class StandardHomeSearch extends StatelessWidget implements PreferredSizeWidget {
  const StandardHomeSearch({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark?null:Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 15),
          FeedbackWidget(
            onPressed: () => _openDrawer(context),
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/icon_head.webp'),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    FadePageRoute(child: const StandardSearchPageProvider()));
              },
              child: Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:  Material(
                    color: Colors.transparent,
                    child: TextField(
                      autofocus: false,
                      enabled: false,
                      cursorColor: Colors.blue,
                      maxLines: 1,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark?Color(0xff292929):Color(0xffF3F6F9),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35 / 2)),
                          ),
                          hintText: "搜索组件",
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  )),
            ),
          ),
          const Icon(TolyIcon.icon_sound),
          const SizedBox(width: 15)
        ],
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
