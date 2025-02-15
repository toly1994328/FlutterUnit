import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

import '../../mobile/mobile_ui.dart';
import '../../mobile/widget_detail/category_end_drawer.dart';
import '../../mobile/widget_detail/node_display/node_display.dart';
import 'link_widget_buttons.dart';
import 'widget_detail_bar.dart';
import 'widget_detail_panel.dart';

// 用于组件详情不需要在一开始就加载
// WidgetDetailBloc 可以在稍后提供
class DeskWidgetDetailPageScope extends StatefulWidget {
  final WidgetModel? model;
  final String? widgetName;

  const DeskWidgetDetailPageScope(
      {super.key, required this.model, this.widgetName});

  @override
  State<DeskWidgetDetailPageScope> createState() =>
      _DeskWidgetDetailPageScopeState();
}

class _DeskWidgetDetailPageScopeState extends State<DeskWidgetDetailPageScope> {
  WidgetModel? _model;

  WidgetRepository get widgetRepository =>
      context.read<WidgetsBloc>().repository;

  NodeRepository get nodeRepository =>
      kIsWeb ? MemoryNodeRepository() : const NodeDbRepository();

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    if (_model == null) {
      _loadModelByName();
    }
  }

  void _loadModelByName() async {
    _model = await widgetRepository.queryWidgetByName(widget.widgetName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_model == null)
      return const Center(child: CupertinoActivityIndicator());
    Locale locale =  context.read<AppConfigBloc>().state.language.locale;
    // Locale locale = Localizations.localeOf(context);
    // String? countryCode = locale.countryCode;
    // if (countryCode == null) {}
    String localeStr = '${locale.languageCode}-${locale.countryCode}'.toLowerCase();

    return BlocProvider<WidgetDetailBloc>(
      create: (_) => WidgetDetailBloc(
        widgetRepo: widgetRepository,
        nodeRepo: nodeRepository,
      )..push(_model!, locale: localeStr),
      child: DeskWidgetDetailPage(
        model: widget.model,
      ),
    );
  }
}

class DeskWidgetDetailPage extends StatelessWidget {
  final WidgetModel? model;

  const DeskWidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetDetailBloc bloc = context.watch<WidgetDetailBloc>();
    DetailState state = context.watch<WidgetDetailBloc>().state;
    WidgetModel widget = bloc.currentWidget;
    return BlocListener<AppConfigBloc, AppConfig>(
      listenWhen: (p, n) => p.language != n.language,
      listener: (_, state) {
        BlocProvider.of<WidgetDetailBloc>(context)
            .changeLocale(state.language.locale);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        endDrawer: CategoryEndDrawer(widget: widget),
        body: Builder(builder: (ctx) {
          return _buildContent(ctx, bloc, state);
        }),
      ),
    );
  }

  Widget linkText(BuildContext context) => Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.link, color: Colors.blue),
          ),
          Text(context.l10n.relatedComponents, style: UnitTextStyle.labelBold),
        ],
      );

  Widget _buildContent(
      BuildContext context, WidgetDetailBloc bloc, DetailState state) {
    return WillPopScope(
        onWillPop: () => _whenPop(context),
        child: CustomScrollView(
          slivers: [
            DeskSliverWidgetDetailBar(model: bloc.currentWidget),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  DeskWidgetDetailPanel(model: bloc.currentWidget, state: state,),
                  const Divider(height: 18,)
                ],
              ),
            ),
            if (state is DetailWithData)
              SliverNodeList(
                nodes: state.nodes,
                model: state.widgetModel,
              )
          ],
        ));
  }

  Future<bool> _whenPop(BuildContext context) async {
    WidgetDetailBloc detailBloc = context.read<WidgetDetailBloc>();
    if (Scaffold.of(context).isEndDrawerOpen) {
      return true;
    }
    return detailBloc.pop();
  }
}
