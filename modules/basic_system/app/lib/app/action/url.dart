// Copyright 2014 The 张风捷特烈 . All rights reserved.

// Author:      张风捷特烈
// CreateTime:  2024-07-07
// Contact Me:  1981462002@qq.com

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

void jumpURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(uri,mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $url');
  }
}