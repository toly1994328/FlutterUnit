import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_ability/fx_ability.dart';
import 'package:l10n/l10n.dart';
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
        title: Text(context.l10n.workshop),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: context.l10n.exchangeHistory,
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
      final String message = state.error == null
          ? context.l10n.noWorkshopProducts
          : context.l10n.operationFailed;
      return Center(child: Text(message));
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
        Text(context.l10n.myCraftDust),
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
          children: <String, Widget>{
            'avatar_frame': Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(context.l10n.avatarFrames),
            ),
            'badge': Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(context.l10n.badges),
            ),
            'owned': Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(context.l10n.owned),
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
        decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.outlineVariant),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Image.network(
                        FlutterUnitHost.resolveImageResource(
                          product.honorAssetUrl,
                        ).toString(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
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
                  Center(
                    child: product.owned
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                context.l10n.goEquip,
                                style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: colors.primary,
                                size: 14,
                              ),
                            ],
                          )
                        : buying
                            ? const SizedBox.square(
                                dimension: 14,
                                child:
                                    CircularProgressIndicator(strokeWidth: 1.5),
                              )
                            : Text(
                                context.l10n.exchange,
                                style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 12,
                                ),
                              ),
                  ),
                ],
              ),
            ),
            if (!product.owned)
              Positioned(
                left: 4,
                top: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _CurrencyLogo(assetUrl: currencyAssetUrl),
                    const SizedBox(width: 3),
                    Text(
                      '${product.pricePoints}',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final bool? accepted = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
                title: Text(product.honorName, textAlign: TextAlign.center),
                content: Text(
                  context.l10n.exchangeWithCraftDust(product.pricePoints),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: Text(context.l10n.cancel)),
                  TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: Text(context.l10n.confirmExchange))
                ]));
    if (accepted != true || !context.mounted) return;
    final String? error = await context.read<WorkshopCubit>().purchase(product);
    if (error != null) {
      if (error == '匠尘余额不足' && context.mounted) {
        await _showInsufficientBalanceDialog(context);
        return;
      }
      if (context.mounted) {
        FxAbility().toast.error(context.l10n.operationFailed);
      }
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
        title: Text(
          context.l10n.insufficientCraftDust,
          textAlign: TextAlign.center,
        ),
        content: Text(context.l10n.earnCraftDustHint),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.l10n.goToTasks),
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
