import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, height: 200,
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.blue.withAlpha(120),
          trailing: Icon(
            Icons.star,
            color: Colors.red,
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/wy_200x300.jpg"),
          ),
          title: Text("百里·巫缨"),
          subtitle: Text("倾国必倾城"),
        ),
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            "assets/images/sabar.jpg",
            fit: BoxFit.cover,
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ID:z\$ySX32&29",
            style: TextStyle(shadows: [
              Shadow(
                  color: Colors.blue,
                  offset: Offset(.1, .1),
                  blurRadius: 2),
            ]),
          ),
        ),
      ),
    );
  }
}
