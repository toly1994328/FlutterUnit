import 'package:flutter/material.dart';

class UndoHistoryDemo1 extends StatefulWidget {
  const UndoHistoryDemo1({super.key});

  @override
  State<UndoHistoryDemo1> createState() => _UndoHistoryDemo1State();
}

class _UndoHistoryDemo1State extends State<UndoHistoryDemo1> {
  final UndoHistoryController _undoController = UndoHistoryController();

  @override
  void dispose() {
    _undoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildToolBar(),
          const Divider(height: 0.5),
          Expanded(
              child: TextField(
            undoController: _undoController,
            expands: true,
            maxLines: null,
            minLines: null,
            decoration: InputDecoration(
              filled: true,
              hintText: '请输入...',
              fillColor: Colors.white,
              hoverColor: Colors.transparent,
              border: InputBorder.none,
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildToolBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ValueListenableBuilder<UndoHistoryValue>(
        valueListenable: _undoController,
        builder: (BuildContext context, UndoHistoryValue value, Widget? child) {
          return Wrap(
            spacing: 4,
            children: <Widget>[
              _IconAction(
                  icon: Icons.undo,
                  onTap: value.canUndo ? _undoController.undo : null),
              _IconAction(
                  icon: Icons.redo,
                  onTap: value.canRedo ? _undoController.redo : null),
            ],
          );
        },
      ),
    );
  }
}

class _IconAction extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconAction({super.key, required this.icon, this.onTap});

  @override
  State<_IconAction> createState() => _IconActionState();
}

class _IconActionState extends State<_IconAction> {
  bool _hover = false;

  bool get enable => widget.onTap != null;

  Color? get color => (_hover && enable) ? Colors.grey.withOpacity(0.2) : null;

  @override
  Widget build(BuildContext context) {
    MouseCursor cursor = (_hover && enable) ? SystemMouseCursors.click : SystemMouseCursors.basic;
    return MouseRegion(
      cursor: cursor ,
      onExit: (_) => setState(() => _hover = false),
      onEnter: (_) => setState(() => _hover = true),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              widget.icon,
              size: 20,
              color: enable ? null : Colors.grey,
            )),
      ),
    );
  }
}
