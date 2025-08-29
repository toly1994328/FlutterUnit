import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:storage/storage.dart';

class WidgetFieldsDialog extends StatefulWidget {
  final int widgetId;
  final String widgetName;

  const WidgetFieldsDialog({
    super.key,
    required this.widgetId,
    required this.widgetName,
  });

  @override
  State<WidgetFieldsDialog> createState() => _WidgetFieldsDialogState();
}

class _WidgetFieldsDialogState extends State<WidgetFieldsDialog> {
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
      // SQL已经按必需属性排序，不需要再次排序
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 500,
        height: 600,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.widgets, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          '${widget.widgetName} 属性',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_fields!.isEmpty) return const Center(child: Text('暂无属性信息'));

    return ListView.builder(
      itemCount: _fields!.length,
      itemBuilder: (context, index) => _buildFieldItem(_fields![index]),
    );
  }

  Widget _buildFieldItem(WidgetFieldModel field) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${field.fieldName} : ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: field.fieldType,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              // if (field.isRequired) _buildRequiredBadge(),
            ],
          ),
          if (field.fieldDescZh != null) ...[
            const SizedBox(height: 4),
            Text(
              field.fieldDescZh!,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequiredBadge() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        '必需',
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
