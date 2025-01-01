import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
class MobileToolPage extends StatelessWidget {
  const MobileToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = context.l10n;
    String title = l10n.treasureTools;
    String building = l10n.knowledgeConstruction;
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Center(
        child: Text(building),
      ),
    );
  }
}

