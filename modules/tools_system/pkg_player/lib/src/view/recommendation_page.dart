import 'package:flutter/material.dart';

class RecommendationPage extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final _formKey = GlobalKey<FormState>();
  final _packageNameController = TextEditingController();
  final _featuresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('推荐插件'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text(
                          '推荐说明',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '推荐后，经过审核采纳，该包将收录到 FlutterUnit 插件库中，供更多开发者发现和使用。',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              Text(
                '包名称',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _packageNameController,
                decoration: InputDecoration(
                  hintText: '请输入包名称，如：dio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.extension),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入包名称';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 20),
              
              Text(
                '包的特点',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _featuresController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '请描述这个包的主要功能和特点，为什么推荐它...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请描述包的特点';
                  }
                  if (value.trim().length < 10) {
                    return '请至少输入10个字符的描述';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitRecommendation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '提交推荐',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRecommendation() {
    if (_formKey.currentState!.validate()) {
      // TODO: 实现提交推荐逻辑
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('推荐已提交，感谢您的贡献！'),
          backgroundColor: Colors.green,
        ),
      );
      
      // 清空表单
      _packageNameController.clear();
      _featuresController.clear();
      
      // 返回上一页
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _packageNameController.dispose();
    _featuresController.dispose();
    super.dispose();
  }
}