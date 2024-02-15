import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app_stater/view/flutter_unit_text.dart';
import 'package:toly_ui/toly_ui.dart';

class DeskAccountPage extends StatefulWidget {
  const DeskAccountPage({super.key});

  @override
  State<DeskAccountPage> createState() => _DeskAccountPageState();
}

class _DeskAccountPageState extends State<DeskAccountPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        DeskAccountTopBar(
          leading: FlutterUnitText(
            text: 'Flutter Unit',
          ),
        ),
        Expanded(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserHeader(),
            ),
            SliverPinnedHeader(
                color: isDark?Color(0xff2C3036):Colors.white,
                child: TabBar(
                  onTap: (i) {},
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  // indicator: RoundRectTabIndicator(
                  //   borderSide: BorderSide(color: themeColor, width: 3),
                  // ),
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: tabController,
                  // labelColor: themeColor,
                  indicatorWeight: 3,
                  unselectedLabelColor: Colors.grey,
                  // indicatorColor: themeColor,
                  tabs: ['收藏', "分享", "合集"]
                      .map((String name) => Tab(text: name))
                      .toList(),
                )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  title: Text('测试数据: $index',style: TextStyle(color: Colors.grey),),
                ),
                childCount: 20
              ),
            )
          ],
        ))
      ],
    );
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/base_draw.webp',
              height: 150,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 32 + 100 + 16, top: 12),
              color: isDark?Color(0xff2C3036):Colors.white,
              height: 86,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '张风捷特烈',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '海的彼岸有我未曾见证的风采',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '公众号@编程之王',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          bottom: 16,
          left: 32,
          child: CircleImage(
            size: 100,
            shadowColor: Theme.of(context)
                .primaryColor
                .withAlpha(33), // image: NetworkImage(state.user.userAvatar),
            image: const AssetImage("assets/images/icon_head.webp"),
          ),
        ),
      ],
    );
  }
}
