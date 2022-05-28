import 'package:flutter/material.dart';
import 'package:i10n/l10n/i10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('es');

  Locale get locale => _locale;

  set locale(Locale locale) {
    if (!I10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
