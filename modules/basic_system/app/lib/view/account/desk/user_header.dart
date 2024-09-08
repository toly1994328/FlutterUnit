import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String image = isDark?'anim_draw.webp':'base_draw.webp';

    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/$image',
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