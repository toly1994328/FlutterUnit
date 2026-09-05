import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_ability/fx_ability.dart';
import '../../honors/bloc/avatar_frame_cubit.dart';
import '../../progression/bloc/progression_cubit.dart';
import '../../workshop/bloc/workshop_cubit.dart';
import '../../workshop/model/workshop_item.dart';
import 'workshop_purchase_page.dart';

/// 使用匠尘兑换头像框与徽章的商品页。
class WorkshopPage extends StatelessWidget {
  const WorkshopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surfaceContainer,
      appBar: AppBar(
        title: const Text('匠心工坊'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: '兑换记录',
            onPressed: () => Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider<WorkshopCubit>.value(
                  value: context.read<WorkshopCubit>(),
                  child: const WorkshopPurchasePage(),
                ),
              ),
            ),
            icon: const Icon(Icons.receipt_long_outlined),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const _BalanceHeader(),
          const _KindFilter(),
          Expanded(
            child: BlocBuilder<WorkshopCubit, WorkshopState>(
              builder: _buildProducts,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProducts(BuildContext context, WorkshopState state) {
    if (state.loading && state.products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.products.isEmpty) {
      return Center(child: Text(state.error ?? '暂无上架商品'));
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 32),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.72,
      ),
      itemCount: state.products.length,
      itemBuilder: (_, int index) =>
          _ProductCard(product: state.products[index]),
    );
  }
}

class _BalanceHeader extends StatelessWidget {
  const _BalanceHeader();

  @override
  Widget build(BuildContext context) {
    final ProgressionState state = context.watch<ProgressionCubit>().state;
    final String assetUrl = state.overview?.currency.assetUrl ?? '';
    final int balance = state.overview?.pointsBalance ?? 0;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: <Widget>[
        Image.network(
          FlutterUnitHost.resolveImageResource(assetUrl).toString(),
          width: 42,
          height: 42,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.auto_awesome, size: 32),
        ),
        const SizedBox(width: 10),
        const Text('我的匠尘'),
        const Spacer(),
        Text('$balance',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

class _KindFilter extends StatelessWidget {
  const _KindFilter();

  @override
  Widget build(BuildContext context) {
    final WorkshopCubit cubit = context.read<WorkshopCubit>();
    final String? selected =
        context.select((WorkshopCubit value) => value.state.kind);
    final String selectedKey = selected ?? 'avatar_frame';
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<String>(
          groupValue: selectedKey,
          padding: const EdgeInsets.all(3),
          children: const <String, Widget>{
            'avatar_frame': Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('头像框'),
            ),
            'badge': Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('徽章'),
            ),
            'owned': Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('已拥有'),
            ),
          },
          onValueChanged: (String? value) => _select(cubit, value),
        ),
      ),
    );
  }

  void _select(WorkshopCubit cubit, String? value) {
    if (value == null) return;
    cubit.load(value);
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final WorkshopProduct product;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool buying = context.select(
        (WorkshopCubit cubit) => cubit.state.buyingCode == product.code);
    final String currencyAssetUrl = context.select(
      (ProgressionCubit cubit) => cubit.state.overview?.currency.assetUrl ?? '',
    );
    return GestureDetector(
      onTap: buying
          ? null
          : product.owned
              ? () => context.push(_honorsLocation(product.honorKind))
              : () => _confirm(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.outlineVariant),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Image.network(
                          FlutterUnitHost.resolveImageResource(
                                  product.honorAssetUrl)
                              .toString(),
                          fit: BoxFit.contain))),
              SizedBox(
                width: double.infinity,
                child: Text(
                  product.honorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 6),
              Row(children: <Widget>[
                if (product.owned)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '去佩戴',
                          style: TextStyle(color: colors.primary, fontSize: 12),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: colors.primary,
                          size: 14,
                        ),
                      ],
                    ),
                  )
                else ...<Widget>[
                  _CurrencyLogo(assetUrl: currencyAssetUrl),
                  const SizedBox(width: 3),
                  Text('${product.pricePoints}',
                      style: TextStyle(
                          color: colors.primary, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  if (buying)
                    const SizedBox.square(
                        dimension: 14,
                        child: CircularProgressIndicator(strokeWidth: 1.5))
                  else
                    Text('兑换',
                        style: TextStyle(color: colors.primary, fontSize: 12)),
                ]
              ]),
            ]),
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final bool? accepted = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
                title: Text(product.honorName, textAlign: TextAlign.center),
                content: Text('使用 ${product.pricePoints} 匠尘兑换？'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: const Text('取消')),
                  TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: const Text('确认兑换'))
                ]));
    if (accepted != true || !context.mounted) return;
    final String? error = await context.read<WorkshopCubit>().purchase(product);
    if (error != null) {
      if (error == '匠尘余额不足' && context.mounted) {
        await _showInsufficientBalanceDialog(context);
        return;
      }
      FxAbility().toast.error(error);
      return;
    }
    if (context.mounted) {
      await context.read<ProgressionCubit>().load();
      if (context.mounted) await context.read<AvatarFrameCubit>().load();
    }
  }

  /// 匠尘不足时引导用户前往每日任务获取奖励。
  Future<void> _showInsufficientBalanceDialog(BuildContext context) async {
    final bool? goToTasks = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('匠尘不足', textAlign: TextAlign.center),
        content: const Text('完成每日任务可以获得更多匠尘。'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('去做任务'),
          ),
        ],
      ),
    );
    if (goToTasks == true && context.mounted) {
      context.push(AppRoute.progression.url);
    }
  }

  /// 根据商品类型生成佩戴页地址，并激活对应 Tab。
  String _honorsLocation(String kind) {
    return Uri(
      path: AppRoute.honors.url,
      queryParameters: {'tab': kind},
    ).toString();
  }
}

class _CurrencyLogo extends StatelessWidget {
  const _CurrencyLogo({required this.assetUrl});

  /// 服务端下发的匠尘图标地址。
  final String assetUrl;

  @override
  Widget build(BuildContext context) {
    if (assetUrl.isEmpty) {
      return Icon(
        Icons.auto_awesome_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 18,
      );
    }
    return Image.network(
      FlutterUnitHost.resolveImageResource(assetUrl).toString(),
      width: 20,
      height: 20,
      fit: BoxFit.contain,
      errorBuilder: _buildFallback,
    );
  }

  Widget _buildFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Icon(
      Icons.auto_awesome_rounded,
      color: Theme.of(context).colorScheme.primary,
      size: 18,
    );
  }
}
