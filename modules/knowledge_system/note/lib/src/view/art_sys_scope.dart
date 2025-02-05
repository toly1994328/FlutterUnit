import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/note.dart';

class ArtSysScope extends StatelessWidget {
  final Widget child;

  const ArtSysScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArtSysBloc>(
      create: (_) => ArtSysBloc()..loadFirstFrame(),
      child: child,
    );
  }
}
