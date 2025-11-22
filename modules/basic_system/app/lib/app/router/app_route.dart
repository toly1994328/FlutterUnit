enum AppRoute {
  home('/', url: '/'),
  splash('splash', url: '/splash'),
  startError('start_error', url: '/start_error'),
  globalError('404', url: '/404'),

  /// widget module
  widget('widget', url: '/widget'),
  widgetDetail('detail/:name', url: '/widget/detail/'),
  collection('collection', url: '/collection'),
  collectionDetail('widgets/:id', url: '/collection/widgets/'),

  note('note', url: '/note'),
  packages('packages', url: '/packages'),
  moreNews('more_news', url: '/more_news'),
  painter('painter', url: '/painter'),
  knowledge('knowledge', url: '/knowledge'),
  tools('tools', url: '/tools'),

  /// user/app
  aboutApp('about_app', url: '/about_app'),
  account('account', url: '/account'),
  dataManage('data_manage', url: '/data_manage'),
  aboutMe('about_me', url: '/about_me'),
  supportMe('support_me', url: '/support_me'),

  /// settings
  settings('settings', url: '/settings'),
  darkModel('dark_mode', url: '/setting/dark_mode'),
  codeStyle('code_style', url: '/setting/code_style'),
  themeColor('theme_color', url: '/setting/theme_color'),
  fontSetting('font_setting', url: '/setting/font_setting'),
  version('version', url: '/settings/version'),
  ;

  final String path;
  final String url;

  const AppRoute(
    this.path, {
    required this.url,
  });
}
