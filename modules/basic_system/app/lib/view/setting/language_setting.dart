import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingLanguage),
      ),
      body: const LanguageSetting(),
    );
  }
}

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    List<Language> languages = Language.values;
    Language activeLanguage =
        context.select<AppConfigBloc, Language>((bloc) => bloc.state.language);
    Color iconColor = Theme.of(context).primaryColor;

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        Language language = languages[index];
        return ListTile(
          title: Text(language.label),
          onTap: () {
            context.read<AppConfigBloc>().switchLanguage(language);
          },
          trailing: activeLanguage == language
              ? Icon(Icons.check, size: 20, color: iconColor)
              : null,
        );
      },
      itemCount: languages.length,
    );
  }
}

class LanguageSwitchTile extends StatelessWidget {
  const LanguageSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    Language activeLanguage =
        context.select<AppConfigBloc, Language>((bloc) => bloc.state.language);
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      leading: Icon(
        Icons.language,
        color: color,
      ),
      title: Text(context.l10n.settingLanguageText,
          style: TextStyle(fontSize: 16)),
      subtitle: Text(
        '${activeLanguage.label}: ${activeLanguage.locale}',
        style: TextStyle(fontSize: 12),
      ),
      trailing: Icon(Icons.chevron_right, color: color),
      onTap: () {
        showModalBottomSheet(
            context: context, builder: (_) => LanguageSettingPage());
      },
    );
  }
}
