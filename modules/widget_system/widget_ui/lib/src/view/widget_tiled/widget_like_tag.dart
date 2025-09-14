import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:widget_ui/widget_ui.dart';

class LikeTag extends StatelessWidget {
  final WidgetModel model;
  final ValueChanged<WidgetAction> onWidget;

  const LikeTag({
    super.key,
    required this.model,
    required this.onWidget,
  });

  @override
  Widget build(BuildContext context) {
    bool show =
        context.select((LikeWidgetBloc bloc) => bloc.state.contains(model));
    if (show) {
      return GestureDetector(
        onTap: () => onWidget(ToggleLikeWidget(model.id)),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomRight: Radius.circular(8),
              )),
          child: Icon(
            Icons.star,
            color: Colors.white,
            size: 16,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
