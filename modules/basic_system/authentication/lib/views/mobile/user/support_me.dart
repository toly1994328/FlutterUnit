import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

class SupportMe extends StatelessWidget {
  const SupportMe({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(context.l10n.homeAccountSupport),
              Text(
                context.l10n.supportPrompt,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: context.l10n.alipay),
              Tab(text: context.l10n.wechatOne),
              Tab(text: context.l10n.wechatTwo),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Image.asset(
              'assets/images/coffee_zfb.webp',
            ),
            Image.asset('assets/images/coffee_wx.webp'),
            Image.asset('assets/images/coffee_wx_ac.webp'),
          ],
        ),
      ),
    );
  }
}
