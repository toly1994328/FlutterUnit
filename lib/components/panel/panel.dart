import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/components/code/code_panel.dart';
import 'package:toggle_rotate/toggle_rotate.dart';

import 'circle.dart';

class Panel extends StatelessWidget {
  final double radius;
  final Color color;
  final Widget child;

  Panel({this.radius = 5.0, this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color ?? Color(0xffF6F8FA),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}

class NodePanel extends StatefulWidget {
  final String text;
  final String subText;
  final String code;
  final Widget show;

  NodePanel({this.text, this.subText, this.code, this.show});

  @override
  _NodePanelState createState() => _NodePanelState();
}

class _NodePanelState extends State<NodePanel>
    with SingleTickerProviderStateMixin {
  bool _showCode = false;
  AnimationController _ctrl;
  double _sizeFactor = 0;
  Animation<double> _expend;

  @override
  void initState() {
    _ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {
              _sizeFactor = (_showCode ? (1 - _expend.value) : _expend.value);
            });
          })
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              setState(() {
                _showCode = !_showCode;
              });
            }
          });
    _expend = Tween(begin: 0.0, end: 1.0).animate(_ctrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Circle(
                  color: Colors.orange,
                  radius: 5,
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.text}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ToggleRotate(
                  durationMs: 300,
                  child: Icon(Icons.code,color: Colors.orange,),
                  onTap: () {
                    setState(() {
//                      _showCode = !_showCode;
                      _ctrl.reset();
                      _ctrl.forward();
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _buildCode(context),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: widget.show,
          ),
          Container(
            width: double.infinity,
            child: Panel(
                child: Text(
              '${widget.subText}',
              style: TextStyle(fontSize: 14),
            )),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) =>
    ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: _sizeFactor,
        child: ScaleTransition(
          scale: Tween(begin: 0.5,end: 1.0).animate(_ctrl),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Panel(
              child: CodeWidget(
                code: widget.code,
              ),
            ),
          ),
        ),
      ),
    );

}
