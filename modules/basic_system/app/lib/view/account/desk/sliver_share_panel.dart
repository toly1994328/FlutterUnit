import 'package:flutter/material.dart';

class SliverSharePanel extends StatelessWidget {
  const SliverSharePanel({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      const SizedBox(height: 12),
      const Text(
          '邮箱: 1981462002@qq.com\n'
          '微信群: 编程技术交流圣地 -【Flutter群】\n'
          '公众号: 编程之王\n'
              '愿青梅煮酒，与君天涯共话。',
          style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset(
                  'assets/images/wechat.webp',
                  width: 200,
                  height: 200,
                ),
              ),
              const Center(
                child: Text(
                  '我的微信',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20,),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset(
                  'assets/images/wxgzh.webp',
                  width: 200,
                  height: 200,
                ),
              ),
              const Center(
                child: Text(
                  '我的公众号',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),

    ];


    return SliverToBoxAdapter(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }
}
