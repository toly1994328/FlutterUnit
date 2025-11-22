import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

class PluginDependenciesSection extends StatelessWidget {
  final Map<String, dynamic>? dependencies;

  const PluginDependenciesSection({Key? key, required this.dependencies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dependencies == null || dependencies!.isEmpty) {
      return SizedBox.shrink();
    }
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.pkgL10n.dependencies,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: dependencies!.entries.map((entry) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade50, Colors.blue.shade100],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.2),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      "${entry.key}: ${entry.value.toString()}",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
