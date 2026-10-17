import 'package:artifact/src/articles/bloc/columnize/bloc.dart';
import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/article/columnize_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('专栏请求失败后可以重新获取空列表', testColumnRetry);
  testWidgets('线上专栏为空时不会发生对零取模', testEmptyCarousel);
}

class EmptyColumnRepository extends ColumnizeRepository {
  /// 控制首次请求失败，验证重试流程。
  bool fail = false;

  @override
  Future<List<Columnize>> query() async {
    if (fail) throw StateError('断网');
    return <Columnize>[];
  }
}

Future<void> testColumnRetry() async {
  final EmptyColumnRepository repo = EmptyColumnRepository()..fail = true;
  final ColumnizeBloc bloc = ColumnizeBloc(repo);
  await bloc.init();
  expect(bloc.state.error, isNotNull);
  expect(bloc.state.loading, isFalse);
  repo.fail = false;
  await bloc.refresh();
  expect(bloc.state.error, isNull);
  expect(bloc.state.data, isEmpty);
  await bloc.close();
}

Future<void> testEmptyCarousel(WidgetTester tester) async {
  final ColumnizeBloc bloc = ColumnizeBloc(EmptyColumnRepository());
  await bloc.init();
  await tester.pumpWidget(MaterialApp(
    home: BlocProvider<ColumnizeBloc>.value(
      value: bloc,
      child: const SizedBox(height: 220, child: ColumnizePageView()),
    ),
  ));
  expect(find.text('暂无专栏'), findsOneWidget);
  expect(tester.takeException(), isNull);
  await bloc.close();
}
