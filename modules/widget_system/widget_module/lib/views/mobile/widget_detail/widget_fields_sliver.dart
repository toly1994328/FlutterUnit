import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';

class SliverWidgetFieldsList extends StatefulWidget {
  final int widgetId;

  const SliverWidgetFieldsList({
    super.key,
    required this.widgetId,
  });

  @override
  State<SliverWidgetFieldsList> createState() => _SliverWidgetFieldsListState();
}

class _SliverWidgetFieldsListState extends State<SliverWidgetFieldsList> {
  List<WidgetFieldModel>? _fields;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    try {
      final repository = const WidgetDbRepository();
      final fields = await repository.loadWidgetFields(widget.widgetId);
      setState(() {
        _isLoading = false;
        _fields = fields;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _fields = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_fields!.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text('暂无属性信息'),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildFieldItem(_fields![index]),
          childCount: _fields!.length,
        ),
      ),
    );
  }

  Widget _buildFieldItem(WidgetFieldModel field) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  field.fieldName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              // if (field.isRequired) _buildRequiredBadge(),
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              field.fieldType,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (field.fieldDescZh != null) const SizedBox(height: 8),
          Text(
            field.fieldDescZh!,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        '必需',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
