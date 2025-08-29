import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:widget_ui/widget_ui.dart';
import '../blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

class WidgetsBlocProvider extends StatefulWidget {
  final Widget child;

  const WidgetsBlocProvider({super.key, required this.child});

  @override
  State<WidgetsBlocProvider> createState() => _WidgetsBlocProviderState();
}

class _WidgetsBlocProviderState extends State<WidgetsBlocProvider> {
  late WidgetRepository repository;
  final CategoryBloc categoryBloc =
      CategoryBloc(repository: CategoryDbRepository());

  @override
  void initState() {
    super.initState();
    if (kAppEnv.isWeb) {
      repository = MemoryWidgetRepository();
    } else {
      repository = const WidgetDbRepository();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WidgetsBloc>(
            create: (_) => WidgetsBloc(repository: repository)),
        BlocProvider<CategoryBloc>(create: (_) => categoryBloc),
        BlocProvider<LikeWidgetBloc>(
            create: (_) => LikeWidgetBloc(repository: repository)),
        BlocProvider<CategoryWidgetBloc>(
            create: (_) => CategoryWidgetBloc(categoryBloc: categoryBloc)),
      ],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    categoryBloc.close();
    super.dispose();
  }
}
