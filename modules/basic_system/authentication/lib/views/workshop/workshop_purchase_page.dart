import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:unit_env/unit_env.dart';

import '../../progression/bloc/progression_cubit.dart';
import '../../workshop/bloc/workshop_cubit.dart';
import '../../workshop/model/workshop_item.dart';

/// 展示当前用户的匠尘商品兑换记录。
class WorkshopPurchasePage extends StatefulWidget {
  const WorkshopPurchasePage({super.key});

  @override
  State<WorkshopPurchasePage> createState() => _WorkshopPurchasePageState();
}

class _WorkshopPurchasePageState extends State<WorkshopPurchasePage> {
  @override
  void initState() {
    super.initState();
    context.read<WorkshopCubit>().loadPurchases();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colors.surfaceContainer,
        appBar: AppBar(
          title: Text(context.l10n.exchangeHistory),
          centerTitle: true,
          backgroundColor: colors.surfaceContainer,
          scrolledUnderElevation: 0,
        ),
        body: BlocBuilder<WorkshopCubit, WorkshopState>(
            builder: (BuildContext context, WorkshopState state) {
          if (state.purchases.isEmpty) {
            return Center(child: Text(context.l10n.noExchangeHistory));
          }
          return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.purchases.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, int index) =>
                  _PurchaseTile(item: state.purchases[index]));
        }));
  }
}

class _PurchaseTile extends StatelessWidget {
  const _PurchaseTile({required this.item});

  /// 当前展示的兑换记录。
  final WorkshopPurchase item;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String currencyAssetUrl = context.select(
      (ProgressionCubit cubit) => cubit.state.overview?.currency.assetUrl ?? '',
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          SizedBox.square(
            dimension: 48,
            child: Image.network(
              FlutterUnitHost.resolveImageResource(item.honorAssetUrl)
                  .toString(),
              fit: BoxFit.contain,
              errorBuilder: _buildHonorFallback,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.honorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(item.createdAt),
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (currencyAssetUrl.isNotEmpty)
            Image.network(
              FlutterUnitHost.resolveImageResource(currencyAssetUrl).toString(),
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              errorBuilder: _buildCurrencyFallback,
            )
          else
            _buildCurrencyFallback(context, Object(), null),
          const SizedBox(width: 3),
          Text(
            '-${item.pricePoints}',
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final String value = time.toLocal().toString();
    return value.length >= 16 ? value.substring(0, 16) : value;
  }

  Widget _buildHonorFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Icon(Icons.workspace_premium_outlined,
        color: Theme.of(context).colorScheme.outline);
  }

  Widget _buildCurrencyFallback(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Icon(Icons.auto_awesome_rounded,
        size: 18, color: Theme.of(context).colorScheme.primary);
  }
}
