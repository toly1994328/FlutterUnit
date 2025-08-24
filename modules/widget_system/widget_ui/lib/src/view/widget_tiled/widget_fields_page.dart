import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:storage/storage.dart';

class WidgetFieldsPage extends StatefulWidget {
  final int widgetId;
  final String widgetName;

  const WidgetFieldsPage({
    super.key,
    required this.widgetId,
    required this.widgetName,
  });

  @override
  State<WidgetFieldsPage> createState() => _WidgetFieldsPageState();
}

class _WidgetFieldsPageState extends State<WidgetFieldsPage> {
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
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size(0, 10),
            child: Container(
              height: 10,
              color: Color(0xfff3f4f6),
            )),
        title: Text('${widget.widgetName} 属性'),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_fields!.isEmpty) return const Center(child: Text('暂无属性信息'));

    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemCount: _fields!.length,
      itemBuilder: (context, index) => _buildFieldItem(_fields![index]),
    );
  }

  Widget _buildFieldItem(WidgetFieldModel field) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: field.isRequired
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: field.fieldName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
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
            if (field.fieldDescZh != null) ...[
              const SizedBox(height: 8),
              Text(
                field.fieldDescZh!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
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
