import 'package:app/app.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModelSwitchIcon extends StatelessWidget {

  const ThemeModelSwitchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          context.read<AppConfigBloc>().changeThemeMode(isDark?ThemeMode.light:ThemeMode.dark);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: Icon(
            !isDark?TolyIcon.dark:TolyIcon.wb_sunny,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
