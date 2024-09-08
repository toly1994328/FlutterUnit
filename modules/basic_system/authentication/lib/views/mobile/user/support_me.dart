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
              Text('开源不易, 请我喝咖啡~',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: '支付宝',
              ),
              Tab(
                text: '微信1',
              ),
              Tab(
                text: '微信2',
              ),
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

