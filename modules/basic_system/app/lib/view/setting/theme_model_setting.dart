import 'package:app/app.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModelSetting extends StatelessWidget {
  const ThemeModelSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode mode = context
        .select<AppConfigBloc, ThemeMode>((bloc) => bloc.state.themeMode);
    Color iconColor = Theme.of(context).primaryColor;
    String dark = context.l10n.darkMode;
    String light = context.l10n.lightMode;
    String followSystem = context.l10n.followSystem;
    String manualSetting = context.l10n.manualSetting;
    String info =
        context.l10n.afterOpeningWillFollowTheSystemToOpenOrCloseDarkMode;
    return Scaffold(
      appBar: AppBar(title: Text(dark)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 15,
          ),
          TolySwitchListTile(
            title: Text(followSystem,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text(
              info,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            value: mode == ThemeMode.system,
            onChanged: (bool value) {
              ThemeMode newModel;
              if (value) {
                newModel = ThemeMode.system;
              } else {
                newModel = ThemeMode.light;
              }
              context.read<AppConfigBloc>().changeThemeMode(newModel);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 16, bottom: 6),
            child: Text(manualSetting),
          ),
          ListTile(
            title: Text(light),
            onTap: () {
              context.read<AppConfigBloc>().changeThemeMode(ThemeMode.light);
            },
            trailing: mode == ThemeMode.light
                ? Icon(Icons.check, size: 20, color: iconColor)
                : null,
          ),
          const Divider(),
          ListTile(
            title: Text(dark),
            onTap: () {
              context.read<AppConfigBloc>().changeThemeMode(ThemeMode.dark);
            },
            trailing: mode == ThemeMode.dark
                ? Icon(Icons.check, size: 20, color: iconColor)
                : null,
          )
        ],
      ),
    );
    ;
  }
}
