import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

Future<SortType?> showSortPicker(BuildContext context, SortType current) {
  Color? tileColor = Theme.of(context).listTileTheme.tileColor;
  return showModalBottomSheet<SortType>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),
          Text(
            context.pkgL10n.sortMethod,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          ...SortType.values.map((sortType) {
            final isSelected = current == sortType;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  sortType.getLabel(context),
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Theme.of(context).primaryColor : null,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check_circle,
                        color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  Navigator.pop(ctx, sortType);
                },
              ),
            );
          }).toList(),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}
