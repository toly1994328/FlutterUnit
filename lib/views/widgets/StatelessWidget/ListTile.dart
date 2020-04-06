import 'package:flutter/material.dart';
import 'package:flutter_unit/views/dialogs/dialog_about.dart';


class CustomListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        onLongPress: () => DialogAbout.show(context),
      ),
    );
  }
}

class SelectListTile extends StatefulWidget {
  @override
  _SelectListTileState createState() => _SelectListTileState();
}

class _SelectListTileState extends State<SelectListTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        selected: _selected,
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        onTap: () => setState(() => _selected = !_selected),
      ),
    );
  }
}

class DenseListTile extends StatefulWidget {
  @override
  _DenseListTileState createState() => _DenseListTileState();
}

class _DenseListTileState extends State<DenseListTile> {
  bool _dense = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        selected: false,
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        dense: _dense,
        onTap: () => setState(() => _dense = !_dense),
      ),
    );
  }
}
