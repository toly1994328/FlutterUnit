import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/bloc_exp.dart';


class UpdateRedPoint extends StatelessWidget {
  const UpdateRedPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget radPoint = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (BuildContext context, UpdateState state) {
        if (state is ShouldUpdateState) {
          return radPoint;
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
