import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pkg_player/pkg_player.dart';

import '../home/plugin_item.dart';

class PluginInfoSection extends StatelessWidget {
  final PluginModel plugin;

  const PluginInfoSection({Key? key, required this.plugin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;
    PkgL10n l10n = context.pkgL10n;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plugin.publisher?.isNotEmpty == true)
            _buildInfoRow(Icons.person, l10n.publisher, plugin.publisher!),
          if (plugin.homepage?.isNotEmpty == true)
            _buildInfoRow(Icons.home, l10n.home, plugin.homepage!),
          if (plugin.repository?.isNotEmpty == true)
            _buildRepositoryRow(plugin.repository!, l10n),
          _buildInfoRow(Icons.schedule, l10n.lastRelease,
              formatDate(plugin.lastPublish, l10n)),
          SizedBox(height: 4),
          Divider(),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  l10n.likeCount,
                  plugin.statistics.likes,
                  Icons.favorite,
                  Colors.red,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  l10n.pluginScore,
                  plugin.statistics.points,
                  Icons.bar_chart,
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  l10n.downloadsLast30Days,
                  plugin.statistics.downloads,
                  Icons.download,
                  Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Text('$label:',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey[700])),
          SizedBox(width: 8),
          Expanded(
              child: Text(value, style: TextStyle(color: Colors.grey[800]))),
        ],
      ),
    );
  }

  Widget _buildRepositoryRow(String repository, PkgL10n l10n) {
    final displayName = _extractRepoName(repository);

    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.code, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Text(l10n.repository,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey[700])),
          SizedBox(width: 8),
          Text(displayName, style: TextStyle(color: Colors.blue)),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () => _copyToClipboard(repository),
            child: Icon(
              Icons.copy,
              size: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _extractRepoName(String repository) {
    try {
      final uri = Uri.parse(repository);
      final pathSegments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
      if (pathSegments.length >= 2) {
        return '${pathSegments[pathSegments.length - 2]}/${pathSegments.last}';
      }
      return pathSegments.isNotEmpty ? pathSegments.last : repository;
    } catch (e) {
      return repository;
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  Widget _buildStatItem(String label, int value, IconData icon, Color color) {
    return Column(
      spacing: 4,
      children: [
        Row(
          spacing: 2,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            Text(
              _formatNumber(value),
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
