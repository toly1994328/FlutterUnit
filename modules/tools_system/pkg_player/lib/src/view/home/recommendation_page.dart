import 'package:flutter/material.dart';
import '../../repository/api/request.dart';
import '../../l10n/l10n.dart';

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
        title: Text(context.pkgL10n.recommendPlugin),
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
                          context.pkgL10n.recommendDescription,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      context.pkgL10n.recommendNotice,
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
                context.pkgL10n.packageNameLabel,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _packageNameController,
                decoration: InputDecoration(
                  hintText: context.pkgL10n.enterPackageExample,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.extension),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.pkgL10n.enterPackageName;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                context.pkgL10n.packageFeatures,
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
                  hintText: context.pkgL10n.describePluginForRecommend,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.pkgL10n.describePackageFeatureHint;
                  }
                  if (value.trim().length < 10) {
                    return context.pkgL10n.minDescriptionLength;
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
                    context.pkgL10n.submitRecommendation,
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

  void _submitRecommendation() async {
    if (_formKey.currentState!.validate()) {
      try {
        final request = PackageRequest();
        final result = await request.submitFeedback(
          feedbackType: 'package',
          title: _packageNameController.text.trim(),
          content: _featuresController.text.trim(),
        );

        if (result.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.pkgL10n.recommendSubmitted),
              backgroundColor: Colors.green,
            ),
          );

          _packageNameController.clear();
          _featuresController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.pkgL10n.submitFailedWithMsg(result.msg)),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.pkgL10n.submitFailedNetwork),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _packageNameController.dispose();
    _featuresController.dispose();
    super.dispose();
  }
}
