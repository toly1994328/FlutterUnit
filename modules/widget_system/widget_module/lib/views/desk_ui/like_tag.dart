import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../widget_module.dart';
import '../components/collected_tag.dart';

// typedef test =
typedef Calc = bool Function();

class LikeTag extends StatelessWidget {
  final WidgetModel widget;

  const LikeTag({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    bool show = context.select(
      (LikeWidgetBloc bloc) => bloc.state.widgets.contains(widget),
    );
    if (show) {
      return GestureDetector(
        onTap: (){
          context.read<LikeWidgetBloc>().add(ToggleLikeWidgetEvent(id: widget.id));
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomRight: Radius.circular(8),
            )
          ),
          child: Icon(Icons.star,color: Colors.white,size: 16,),
        ),
      );
    }
    return const SizedBox();
    // BlocBuilder<LikeWidgetBloc, LikeWidgetState>(builder: (_, s) {
    //   bool show = s.widgets.contains(model);
    //   if (!show) return const SizedBox();
    //   return const CollectedTag();
    // }),
    return const Placeholder();
  }
}
