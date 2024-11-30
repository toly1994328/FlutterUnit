import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:widget_module/views/mobile/widget_detail/node_display/code_display.dart';

import 'node_title.dart';

typedef NodeWidgetMapper = Widget Function(NodeModel model);

class NodeDisplay extends StatelessWidget {
  final NodeModel node;
  final NodeWidgetMapper mapper;
  final bool isDeath;

  const NodeDisplay({
    super.key,
    required this.node,
    required this.isDeath,
    required this.mapper,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var style = context.select((AppConfigBloc bloc) => bloc.state.codeStyle);
    bool isDesk = kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;
    EdgeInsets pd = isDesk ? const EdgeInsets.symmetric(horizontal: 24, vertical: 8) : const EdgeInsets.all(8.0);
    return Padding(
      padding: pd,
      child: Column(
        children: [
          NodeTitle(text: node.name),
          const SizedBox(height: 10),
          CodeDisplay(display: mapper(node), code: node.code, style: style),
          if (!isDeath) _buildNodeInfo(primaryColor),
        ],
      ),
    );
  }

  Widget _buildNodeInfo(Color primaryColor) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Panel(
            color: primaryColor.withOpacity(0.04),
            child: Text(
              node.subtitle,
              style: const TextStyle(fontSize: 12),
            )),
      );
}
