import 'package:flutter/cupertino.dart';

import 'gen/l10n.dart';

export 'gen/l10n.dart' show PkgL10n;

extension PkGL10nExt on BuildContext {
  PkgL10n get pkgL10n {
    PkgL10n? app = Localizations.of<PkgL10n>(this, PkgL10n);
    return app!;
  }
}
