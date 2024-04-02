import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app_stater/view/splash/flutter_unit_text.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';

import 'sliver_cellection_panel.dart';
import 'sliver_list_panel.dart';
import 'sliver_share_panel.dart';
import 'user_header.dart';

class DeskAccountPage extends StatefulWidget {
  const DeskAccountPage({super.key});

  @override
  State<DeskAccountPage> createState() => _DeskAccountPageState();
}

class _DeskAccountPageState extends State<DeskAccountPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    List<String> tabs = [
      context.l10n.homeAccountTabInfo,
      context.l10n.homeAccountTabMe,
      context.l10n.homeAccountSupport,
    ];

    return Scaffold(
      body: Column(
        children: [
          DeskAccountTopBar(
            leading: Row(
              children: [
                FlutterUnitText(
                  text: 'Flutter Unit',
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  context.l10n.slogan,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: UserHeader(),
              ),
              SliverPinnedHeader(
                  color: isDark ? Color(0xff2C3036) : Colors.white,
                  child: TabBar(
                    onTap: (i) {
                      setState(() {
                        activeIndex = i;
                      });
                    },
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
                    tabs: tabs
                        .map((String name) => Tab(text: name))
                        .toList(),
                  )),
              if (activeIndex == 0) const SliverCollectionPanel(),
              if (activeIndex == 1) const SliverSharePanel(),
              if (activeIndex == 2) const SliverListPanel(),
            ],
          ))
        ],
      ),
    );
  }
}
